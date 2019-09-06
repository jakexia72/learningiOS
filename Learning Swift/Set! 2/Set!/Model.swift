//
//  Model.swift
//  Set!
//
//  Created by Jake Xia on 2018-12-31.
//  Copyright © 2018 Jake Xia. All rights reserved.
//

import Foundation


class SetGame{
    
    var deck = Deck()
    var selectedCards = [Card]()
    var faceUpCards = [Card]()
    
    var score = 0
    
    func selectionIsASet() -> Bool{
        //var isSet = true
        if(selectedCards.count == 3){
            //for _ in selectedCards.indices{
            var shapeArray = [Int]()
            var colorArray = [Int]()
            var numberArray = [Int]()
            var shadeArray = [Int]()
            for iterator in selectedCards{
                shadeArray.append(iterator.shade.rawValue)
                colorArray.append(iterator.color.rawValue)
                numberArray.append(iterator.number.rawValue)
                shapeArray.append(iterator.shape.rawValue)
            }
            if (shadeArray.isASet && shapeArray.isASet && colorArray.isASet && numberArray.isASet ){
                //deselect()
                return true
            } else {
                deselect()
                
            }
        }
        return false
    }
    
    func deselect(){
        selectedCards = [Card]()
    }
}

class Deck{
    var cards = [Card]()
    
    init(){
        for shape in Card.Shape.all{
            for shade in Card.Shade.all{
                for color in Card.Color.all{
                    for number in Card.Number.all{
                        let card = Card(shape: shape, shade: shade, color: color, number: number)
                        cards.append(card)
                    }
                }
            }
        }
    }
    
    func shuffle(){
        cards.shuffle()
    }
    
}

struct Card: Equatable{
    
    var shape: Shape
    var shade: Shade
    var color: Color
    var number: Number
    
    enum Shape: Int{
        case circle
        case square
        case triangle
        
        static var all: [Shape]{
            return  [circle, square, triangle]
        }
    }
    
    enum Shade: Int{
        case outlined
        case filled
        case stripped
        
        static var all: [Shade]{
            return  [outlined, filled, stripped]
        }
    }
    
    enum Color: Int{
        case yellow
        case magenta
        case cyan
        
        static var all: [Color]{
            return  [yellow, magenta, cyan]
        }
    }
    
    enum Number: Int{
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [one,two,three]
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.shape == rhs.shape && lhs.shade == rhs.shade && lhs.number == rhs.number && lhs.color == rhs.color
    }
}


extension Array where Element : Equatable{
    var isAllSame: Bool?{
        if let firstValue = self.first{
            for iterator in self{
                if iterator != firstValue{
                    return false
                }
            }
            return true
        } else {
            return nil
        }
    }
    
    var isUnique: Bool{
        if self.isEmpty{
            return false
        } else {
            var uniqueArray = [Element]()
            for iterator in self{
                if !uniqueArray.contains(iterator){
                    uniqueArray.append(iterator)
                }
            }
            return uniqueArray.count == self.count
        }
    }
    
    var isASet: Bool{
        return (self.isUnique || self.isAllSame!)
    }
}




