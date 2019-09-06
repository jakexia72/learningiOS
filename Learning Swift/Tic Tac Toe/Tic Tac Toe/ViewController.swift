//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Jake Xia on 2017-12-31.
//  Copyright © 2017 Jake Xia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var turnCounter = 0;
    
    
    var game = ticTacToeGame();
    var p1Marker = "🤖";
    var p2Marker = "👨🏻‍🔧";
    var curPlayerMarker:String{
        if game.isPlayerOnesTurn{
            return p1Marker
        }
        return p2Marker
    }
    
    var prevPlayerMarker:String{
        if game.isPlayerOnesTurn{
            return p2Marker
        }
        return p1Marker
    }
    
    @IBOutlet weak var p2ScoreLabel: UILabel!
    @IBOutlet weak var p1ScoreLabel: UILabel!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.gameHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.chooseHistory))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryCell", for: indexPath)
        //cell.addGestureRecognizer(tapGesture)
        if let button = cell.viewWithTag(1000) as? UIButton{
            button.tag = game.gameHistory.count
            print("made button with tag: \(button.tag)")
            
            var playerMarker: String
            if game.gameHistory.last?.moveByP1 == true{
                playerMarker = p1Marker
            } else {
                playerMarker = p2Marker
            }
            
            button.setTitle("turn \(button.tag) by: \(playerMarker)", for: UIControl.State.normal)
        }
        //cell.textLabel?.text = "\(game.gameHistory[indexPath.row])"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func chooseHistory(_ sender: UIButton) {
        game.revertToMove(sender.tag)
        updateViewFromModel()
    }
    
    @objc func chooseHistory(index: Int){
        
    }

    @IBAction func newGame() {
        print(curPlayerMarker)
        game.newGame()
        //game = ticTacToeGame()
        updateViewFromModel()
    }
    
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet var ButtonCollection: [UIButton]!{
        didSet{
            for button in ButtonCollection{
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    @IBAction func playMove(_ sender: UIButton) {
        //sender.setTitle(curPlayerMarkerString, for: UIControl.State.normal)
        //let index:Int? = ButtonCollection.firstIndex(of: sender)
        let index = sender.tag
        print(index)
        print(sender.tag)
        //print(game.currentBoard)
        if game.gameHistory.first == nil || game.currentBoard?.gameBoard[index ?? 0] == .unfilled {
            game.move(at: index ?? 0)
            //print(game.currentBoard)
            updateViewFromModel()
            
            if (game.checkWin(moveLocation: index ?? 0)){
                announceWinnner()
            } else if (game.gameHistory.count == 9){
                announceTie()
            }
            print(curPlayerMarker)
            print(prevPlayerMarker)
            print("p1SCORE: \(game.p1Score)")
        }
        
    }
    
    func announceWinnner(){
        topLabel.text = "🎉👑\(prevPlayerMarker)👑🎉"
        p1ScoreLabel.text = "\(p1Marker)\(game.p1Score)"
        p2ScoreLabel.text = "\(game.p2Score)\(p2Marker)"

    }
    func announceTie() {
        topLabel.text = "\(prevPlayerMarker) 🤝 \(curPlayerMarker)"
    }
    
    func getPlayerDesign(for marker: Marker)->String{
        switch marker {
        case .x:
            return p1Marker
        case .o:
            return p2Marker
        default:
            return ""
        }
    }
    
    func updateViewFromModel(){
        topLabel.text = "\(curPlayerMarker)'S TURN"
        
        historyTableView.reloadData()
        
        for button in ButtonCollection{
            button.setTitle(getPlayerDesign(for: (game.currentBoard?.gameBoard[button.tag]) ?? .unfilled), for: UIControl.State.normal)
        }
        
            }
    
    
}

