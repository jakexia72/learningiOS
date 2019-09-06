//
//  ViewController.swift
//  Set!
//
//  Created by Jake Xia on 2018-12-31.
//  Copyright © 2018 Jake Xia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerVIew: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //containerVIew.addSubview(<#T##view: UIView##UIView#>)
        newGame()
    }
    
    var game = SetGame()
    
    var cardIdentifyer = [UIButton:Card]()
    
    var selectedButtons:[UIButton]{
        var buttonArray = [UIButton]()
        for button in cards{
            if let b = cardIdentifyer[button]{
                if game.selectedCards.contains(b){
                     buttonArray.append(button)
                }
            }
        }
        return buttonArray
    }
    
    @IBOutlet var cards: [UIButton]!{
        didSet {
            for card in cards{
                card.layer.cornerRadius = 10.0
                card.layer.shadowRadius = 10.0
                card.layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                card.layer.shadowOffset = CGSize(width: 10, height: 10)
                card.layer.shadowOpacity = 0.15;
                card.layer.masksToBounds = false;
            }
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    func updateScoreBoard(){
        scoreLabel.text = "SCORE:\(game.score)"
    }
    
    @IBAction func deselect(_ sender: UIButton) {
        if game.selectedCards.count >= 1 {
            game.deselect()
            game.score -= 1
            updateScoreBoard()
            //selectedButtons = [UIButton]()
            updateSelection()
        }
    }
    
    @IBAction func draw3(_ sender: UIButton) {
        drawCard()
        drawCard()
        drawCard()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        newGame()
    }
    
    
    @IBAction func selectCard(_ sender: UIButton) {
        print("running")
        //print(sender.currentTitle)
        if !selectedButtons.contains(sender) && !sender.isInvisible{
            self.game.selectedCards.append(self.cardIdentifyer[sender]!)
            //selectedButtons.append(sender)
        }
        print(selectedButtons.count)
        //print(game.selectionIsASet())
        if selectedButtons.count == 3 {
            if  game.selectionIsASet(){
                
                game.score += 3
                updateScoreBoard()
                print(selectedButtons.count)
                for button in selectedButtons{
                    hide(button)
                }
                game.deselect()
            } else{
                game.score -= 2
                updateScoreBoard()
            }
            
        }
        updateSelection()
    }
//
//    @IBAction func selectCard(_ sender: UIButton)
//
//    }
    
    func hide(_ button: UIButton){
        button.setTitle("", for: UIControl.State.normal)
        button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        button.layer.borderWidth = 0
    }
    
    //    case yellow
    //    case magenta
    //    case cyan
    //
    
    func addAttributes(from card: Card, onto button: UIButton){
        var color: UIColor
        switch card.color {
        case .yellow: color = #colorLiteral(red: 1, green: 0.8632234456, blue: 0.00168346239, alpha: 1)
        case .magenta: color = #colorLiteral(red: 1, green: 0.0001922522367, blue: 0.8030350429, alpha: 1)
        case .cyan: color = #colorLiteral(red: 0, green: 1, blue: 0.9159591488, alpha: 1)
        }
        var fill: UIColor
        var stroke: NSNumber = 0
        switch card.shade{
        case .filled: fill = color
        case .outlined: fill = #colorLiteral(red: 0, green: 1, blue: 0.9159591488, alpha: 0); stroke = 10
        case .stripped: fill = color.withAlphaComponent(0.25)
        }
        
        var string = ""
        var add = ""
        switch  card.shape {
        case .circle: add = "●"
        case .square: add = "■"
        case .triangle: add = "▲"
        }
        for i in 0..<card.number.rawValue{
            string += add
            if i < card.number.rawValue - 1{
                string += "\n"
            }
        }
        let attributes: [NSAttributedString.Key:Any] = [
            
            .foregroundColor: fill,
            .strokeColor : color,
            .strokeWidth : stroke,
            
            ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func show(card button: UIButton){
        if let element = game.deck.cards.getRandomElement(){
            let card = element.element
            game.faceUpCards.append(game.deck.cards.remove(at: element.index))
            addAttributes(from: card, onto: button)
            button.setTitle("set", for: UIControl.State.normal)
            cardIdentifyer[button] = card
        }
        
    }
    
    func newGame(){
        game = SetGame()
        cards.forEach(hide(_:))
        for _ in 0..<12 {
            drawCard()
        }
        updateSelection()
        
    }
    
    var availibleCardIndices: [Int]{
        var tempArray = [Int]()
        for i in cards.indices{
            if cards[i].isInvisible{
                tempArray.append(i)
            }
        }
        return tempArray
    }
    
    func drawCard(){
        if !(availibleCardIndices.isEmpty){
            let randomCard = cards[availibleCardIndices.getRandomElement()?.element ?? 0]
            show(card: randomCard)
        }
    }
    
    func updateSelection(){
        for button in cards{
            if !button.isInvisible {
                if game.selectedCards.contains(cardIdentifyer[button]!){
                    button.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.4760972799, alpha: 1)
                    button.layer.borderWidth = 2
                } else {
                    button.layer.borderWidth = 0
                }
            }
        }
    }
    
}

extension UIButton{
    var isInvisible: Bool{
        if self.currentTitle == ""{
            return true
        }
        return false
    }
}

extension Array{
    func getRandomElement() -> (element: Element, index: Int)?{
        if self.isEmpty{
            return nil
        }else {
            let index = Int(arc4random_uniform(UInt32(self.count)))
            return (self[index], index)
        }
    }
    
}

