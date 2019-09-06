//
//  ViewController.swift
//  concentration
//
//  Created by Jake Xia on 2018-12-23.
//  Copyright © 2018 Jake Xia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2) //Classes get a free init
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCount()
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var newGameButton: UIButton!{
        didSet{
            updateThemes()
        }
    }

    
    
    @IBAction func newGame(_ sender: UIButton) {
       // game.updateFlipCount()
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        updateViewFromModel()
        updateThemes()
    }
    
    var emojiThemes = [[String]]()
    lazy var emojiChoices = [String]()
    var backgroundThemes = [[UIColor]]()
    var cardBack = #colorLiteral(red: 1, green: 0.5627636666, blue: 0.1842739489, alpha: 1)
    func updateThemes(){
        emojiThemes.append(["🐶","🐱","🐭","🐷","🐵","🦁","🐸","🐯","🐰","🐹","🐣","🐙","🦑"])
        emojiThemes.append(["🥰","🥶","😀","🤬","🤯","🤮","🤢","🤡","😈","🥺","🥳","🤩","😱"])
        emojiThemes.append(["🍈","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🥑","🥝","🍑","🥥","🍍"])
        emojiThemes.append(["⚽️","🏀","🏈","🎱","🎾","⚾️","🥌","⛳️","🏒","🥏","🥊","🎿","🏂"])
        
        backgroundThemes.append([#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)])
        backgroundThemes.append([#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)])
        backgroundThemes.append([#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)])
        backgroundThemes.append([#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),#colorLiteral(red: 0.8990433432, green: 0.9764705896, blue: 0.02351713364, alpha: 1)])
        
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiChoices = emojiThemes[randomIndex]
        
        
        backgroundView.backgroundColor = backgroundThemes[randomIndex][0]
        cardBack = backgroundThemes[randomIndex][1]
        for colorChangeIndex in cardButtons.indices{
            cardButtons[colorChangeIndex].backgroundColor = cardBack
        }
        
        newGameButton.backgroundColor = cardBack
        
        
    }
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if sender.backgroundColor != #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0), sender.title(for: UIControl.State.normal) == ""{
            game.updateFlipCount()
        }
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in card buttons")
        }
    }
    
    func updateFlipCount(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : -5.0,
            .strokeColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        print(attributedString)
        flipCountLabel.attributedText = attributedString
    }
    
    func updateViewFromModel(){
        updateFlipCount()
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBack
            }
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{

       if emojiChoices.count > 0 , emoji[card.identifier] == nil{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return  emoji[card.identifier] ?? "?"
    }
    

}

