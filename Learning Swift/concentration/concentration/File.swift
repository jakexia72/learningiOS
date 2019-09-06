//
//  File.swift
//  concentration
//
//  Created by Jake Xia on 2018-12-23.
//  Copyright © 2018 Jake Xia. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var wasSeenBefore = false
    
    static var  ID = 0
    
    static func getID() -> Int{
        Card.ID += 1
        return Card.ID
    }
    
    init(){
        self.identifier = Card.getID()
    }
}


class Concentration{
    
    var flipCount = 0
    
    var score = 0
    
    var cards = [Card]() //this initializes an EMPTY array of cards
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var pairsFound = 0
    
    func updateFlipCount(){
        flipCount += 1
    }
    
    func resetFlipCount(){
        flipCount = 0
    }
    
    
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    cards[index].wasSeenBefore = false
                    pairsFound += 1
                    if pairsFound == cards.count/2 {
                        flipAllUp()
                    }
                }
                cards[index].isFaceUp = true
                
                print(cards[index].wasSeenBefore)
                
                if(cards[index].wasSeenBefore){
                    score -= 1
                }
                
                cards[index].wasSeenBefore = true
                
            } else {
                //cards[index].isFaceUp = true
                //print(cards[index].wasSeenBefore)
                
                
                cards[index].wasSeenBefore = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func flipAllUp(){
        for flipUpIndex in cards.indices{
            cards[flipUpIndex].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
