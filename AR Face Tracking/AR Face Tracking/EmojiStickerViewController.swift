//
//  ViewController.swift
//  AR Face Tracking
//
//  Created by Jake Xia on 2019-07-03.
//  Copyright © 2019 Jake Xia. All rights reserved.
//

import UIKit
import ARKit

class EmojiStickerViewController: UIViewController {
    let noses = ["🍆", "🐽", "💧", " ", "🎈", "👃"]

    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        // get the location of the tap within the bounds
        let location = sender.location(in: sceneView)
        
        // returns a list of object tapped on from the hit test
        let results = sceneView.hitTest(location, options: nil)
        
        // get the first result and enure that is it an emoji node
        if let result = results.first,
            let node = result.node as? EmojiNode {
            
            // switch the emoji node
            node.next()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard ARFaceTrackingConfiguration.isSupported else {
            //fatal error is a special fucntion that will never return
            fatalError("FACE TRACKING IS NOT SUPPORTED")
        }
        
        sceneView.delegate = self
        
        //sceneView.scene.background.contents = UIColor.black
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //creates a configuration that will track a face
        let config = ARFaceTrackingConfiguration()
        
        //run the face tracking
        sceneView.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //right before closing, will pause the tracking
        sceneView.session.pause()
    }
}


//putting this extension out of the actual class keeps it cleaner
extension EmojiStickerViewController: ARSCNViewDelegate{
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        //ensures that a device with metal/scenekit is being used
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let device = sceneView.device else {
                return nil
        }
        //creates face geometry
        let faceGeometry = ARSCNFaceGeometry(device: device)
        //creates node (allows for the 3D content to be placed)
        let node = SCNNode(geometry: faceGeometry)
        //set fill mode of node's material
        node.geometry?.firstMaterial?.fillMode = .lines
        
        
        node.geometry?.firstMaterial?.transparency = 0.0
        
        
        let noseNode = EmojiNode(with: noses)
        noseNode.name = "nose"
        
        node.addChildNode(noseNode)
        
        updateFeatures(for: node, using: faceAnchor)
        
        return node
        
    }
    
    //function is called to delegate the rendering when node updates
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //checks that anchor passed in works as faceAnchor and geometry works as face geometry
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        faceGeometry.update(from: faceAnchor.geometry)
        updateFeatures(for: node, using: faceAnchor)
    }
    
    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {
        //seach node for a child named "nose"
        let child = node.childNode(withName: "nose", recursively: false) as? EmojiNode
        
        //geometry has an array of verticies, index 9 happens to be the nose vertex
        let vertices = [anchor.geometry.vertices[9]]
        
        child?.updatePosition(for: vertices)
        
    }
}


