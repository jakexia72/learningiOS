//
//  cardView.swift
//  Set!
//
//  Created by Jake Xia on 2019-01-07.
//  Copyright © 2019 Jake Xia. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    var shape: String = "oval" { didSet {setNeedsDisplay(); setNeedsLayout()} }
    var shade: String = "filled" { didSet {setNeedsDisplay(); setNeedsLayout()} }
    var number: Int = 3 { didSet {setNeedsDisplay(); setNeedsLayout()} }
    var color: UIColor = #colorLiteral(red: 0, green: 0.9686274529, blue: 0.8872231773, alpha: 1) { didSet {setNeedsDisplay(); setNeedsLayout()} }
    

    lazy var artImages = createCardImages()
    
    func  createCardImages() -> [CardArt] {
        var images = [CardArt]()
        for _ in 1...number{
            let art = CardArt()
            art.shape = shape
            art.fill = shade
            art.color = color
            addSubview(art)
            images.append(art)
        }
        return images
    }
    
    func configureArtwork(){
        for i in 0..<number{
        
            artImages[i].frame.size = artworkSize
            artImages[i].backgroundColor = UIColor.clear
        }
        
        switch number{
        case 1:
            let newOrigin = CGPoint(x: center.x - artImages[0].bounds.width/2, y: center.y - artImages[0].bounds.height/2)
            artImages[0].frame.origin = newOrigin
        case 2:
            let o1 = CGPoint(x: center.x - artImages[0].bounds.width/2, y: center.y - artImages[0].bounds.height)
            let o2 = CGPoint(x: center.x - artImages[1].bounds.width/2, y: center.y)
            artImages[0].frame.origin = o1
            artImages[1].frame.origin = o2
        default:
            let o1 = CGPoint(x: center.x - artImages[0].bounds.width/2, y: center.y - artImages[0].bounds.height/2)
            let o2 = CGPoint(x: center.x - artImages[1].bounds.width/2, y: center.y - artImages[1].bounds.height - artImages[1].bounds.height/2)
            let o3 = CGPoint(x: center.x - artImages[2].bounds.width/2, y: center.y + artImages[2].bounds.height/2)
        artImages[0].frame.origin = o1
        artImages[1].frame.origin = o2
            artImages[2].frame.origin = o3
            
        }
    }
    
    override func layoutSubviews(){
        print("run")
        super.layoutSubviews()
        configureArtwork()
        for i in 0..<number{
            artImages[i].setNeedsLayout()
            artImages[i].setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.black.setFill()
        roundedRect.fill()
    }
    

}

extension CardView{
    private struct Constants{
        static let cornerRadius: CGFloat = 0.06
        static let widthOfOneArtwork: CGFloat = 0.3
        static let heightOfOneArtwork: CGFloat = 0.2
    }
    private var cornerRadius: CGFloat{
        return bounds.size.height * Constants.cornerRadius
    }
    private var artworkHeight: CGFloat{
        return bounds.size.height * Constants.heightOfOneArtwork
    }
    private var artworkWidth: CGFloat{
        return bounds.size.height * Constants.widthOfOneArtwork
    }
    private var artworkSize: CGSize{
        return CGSize(width: artworkWidth, height: artworkHeight)
    }
    
    
}

@IBDesignable
class CardArt: UIView {
    
    
    var shape: String = "d" { didSet {setNeedsDisplay(); setNeedsLayout()} }
    var color: UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) { didSet {setNeedsDisplay(); setNeedsLayout()} }
    var fill: String = "lines" { didSet {setNeedsDisplay(); setNeedsLayout()} }
    
    var numberOfLines: CGFloat{
        return bounds.width/4
        
    }
    
    override func draw(_ rect: CGRect) {
        let outline = shapePath
        outline.addClip()
        color.setStroke()
        outline.lineWidth = 6
        outline.stroke()
        
        
        if fill == "lines"{
            drawLines()
        } else if fill == "filled"{
            color.setFill()
            outline.fill()
        }

 
    }
    
    func drawLines(){
        let line = UIBezierPath()
        print(bounds.size)
        print("number of lines: \(numberOfLines)")
        for i in 0 ..< Int(numberOfLines){
            let xCoord = (bounds.width / numberOfLines) * CGFloat(i)
            line.move(to: CGPoint(x: xCoord, y: 0))
            line.addLine(to: CGPoint(x: xCoord, y: bounds.width))
            color.setStroke()
            line.stroke()
        }
        
    }
    private var shapePath: UIBezierPath{
        var path = UIBezierPath()
        
        let scaledSize = CGSize(width: bounds.width*0.9, height: bounds.height*0.9)
        let newBounds = CGRect(origin: CGPoint(x: bounds.width*0.05, y: bounds.height*0.05), size: scaledSize)
        
        switch shape{
        case "oval":
            path = UIBezierPath(roundedRect: newBounds, cornerRadius: newBounds.height/2)
        case "diamond":
            let p1 = CGPoint(x: 0, y: newBounds.height/2)
            let p2 = CGPoint(x: newBounds.width/2, y: 0)
            let p3 = CGPoint(x: newBounds.width, y: newBounds.height/2)
            let p4 = CGPoint(x: newBounds.width/2, y: newBounds.height)
            path.move(to: p1)
            path.addLine(to: p2)
            path.addLine(to: p3)
            path.addLine(to: p4)
            path.close()
        default:
            let p1 = CGPoint(x: newBounds.width, y:0)
            let p2 = CGPoint(x: newBounds.width * (2/3), y: newBounds.height)
            let p3 = CGPoint(x: newBounds.width * (1/3), y: newBounds.height/2)
            let p4 = CGPoint(x: 0, y: newBounds.height)
            let p5 = CGPoint(x: newBounds.width * (1/3), y: 0)
            let p6 = CGPoint(x: newBounds.width * (2/3), y: newBounds.height/2)
            path.move(to: p1)
            path.addLine(to: p2)
            path.addLine(to: p3)
            path.addLine(to: p4)
            path.addLine(to: p5)
            path.addLine(to: p6)
            path.close()
        }
        return path
    }
}
