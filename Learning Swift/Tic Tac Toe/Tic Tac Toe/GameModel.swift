//
//  GameModel.swift
//  Tic Tac Toe
//
//  Created by Jake Xia on 2017-12-31.
//  Copyright © 2017 Jake Xia. All rights reserved.
//

import Foundation

let GAMESIZE = 9;

class ticTacToeGame{
    
    var gameHistory = [Board]()
    var currentBoard:Board?{ return gameHistory.last}
    //var lastMoveIndex: Int = -1
    var isPlayerOnesTurn = true;
    var curMarker: Marker{
        if isPlayerOnesTurn{
            return .x
        }
        return .o
    }
    
    var p1Score = 0;
    var p2Score = 0;
    
    
    func checkWin(moveLocation: Int)->Bool{
        
        if let curBoard = currentBoard{
            if curBoard.isOnDiagonal1(element: moveLocation), curBoard.diagonal1.isAllSame {
                incrementScore(moveLocation)
                return true
            } else if curBoard.isOnDiagonal2(element: moveLocation), curBoard.diagonal2.isAllSame{
                incrementScore(moveLocation)
                return true
            }
            
            if (curBoard.getRow(moveLocation).isAllSame || curBoard.getCol(moveLocation).isAllSame){
                return true
            }
            
        }
        return false;
    }
    
    func incrementScore(_ moveLocation: Int){
        if(currentBoard != nil){
            if currentBoard!.gameBoard[moveLocation] == .x{
                p1Score += 1
            } else {
                p2Score += 1
                //I can actually code on this omg
            }
        }
        
    }
    
    
    
    func switchPlayers(){
        isPlayerOnesTurn = !isPlayerOnesTurn
    }
    
    func move(at index: Int){
        
        var newBoard: Board
        if currentBoard != nil {
            print("notNil")
            newBoard = currentBoard!
        } else {
            newBoard = Board()
        }
        newBoard.gameBoard[index] = curMarker
        newBoard.moveByP1 = isPlayerOnesTurn
        addBoardToHistory(newBoard)
        switchPlayers()
        print("sizeFromMove:\(gameHistory.count)")
    }
    
    func addBoardToHistory(_ board: Board){
        gameHistory.append(board)
    }
    
    func revertToMove(_ move: Int){
        print("MOVE: \(move)")
        gameHistory = Array(gameHistory[0..<move])
        isPlayerOnesTurn = !(currentBoard?.moveByP1 ?? false)
        print("SIZE: \(gameHistory.count)")
    }
    
    func newGame(){
        gameHistory = [Board]()
        isPlayerOnesTurn = !isPlayerOnesTurn
    }
    
    
}

enum Marker: Int {
    case unfilled
    case x
    case o
}

struct Board{
    
    var moveByP1 = true
    
    var gameBoard = Array<Marker>(repeating: .unfilled, count: GAMESIZE);
    
    var diagonal1:[Marker]{
        return [gameBoard[0],gameBoard[4],gameBoard[8]]
    }
    var diagonal2:[Marker]{
        return [gameBoard[2],gameBoard[4],gameBoard[6]]
    }
    
    func isOnDiagonal1(element: Int)->Bool{
        switch element {
        case 0,4,8:
            return true;
        default:
            return false;
        }
    }
    
    func isOnDiagonal2(element: Int) -> Bool {
        switch element {
        case 2,4,6:
            return true;
        default:
            return false;
        }
    }
    
    func getRow(_ element: Int)->[Marker]{
        if(element <= 2){
            print("rol 1: \(Array(gameBoard[0..<2+1]))")
            return Array(gameBoard[0..<2+1])
        } else if (element <= 5){
            print("rol 2: \(Array(gameBoard[3..<5+1]))")
            return Array(gameBoard[3..<5+1])
        } else if(element <= 8){
            print("rol 3: \(Array(gameBoard[6..<8+1]))")
            return Array(gameBoard[6..<8+1])
        }
        return [];
    }
    
    func getCol(_ element: Int)->[Marker]{
        if(element <= 2){
            print("col 1:\([gameBoard[element],gameBoard[element+3],gameBoard[element+6]])")
            return [gameBoard[element],gameBoard[element+3],gameBoard[element+6]]
        } else if (element <= 5){
            print("col 2: \([gameBoard[element-3],gameBoard[element],gameBoard[element+3]])")
             return [gameBoard[element-3],gameBoard[element],gameBoard[element+3]]
        } else if(element <= 8){
            print("col 3: \( [gameBoard[element-6],gameBoard[element-3],gameBoard[element]])")
            return [gameBoard[element-6],gameBoard[element-3],gameBoard[element]]
        }
        return [];
    }
    
}

extension Array where Element : Equatable{
    var isAllSame: Bool{
        //print(self)
        if self.count <= 1{
            return false
        }
        if let firstValue = self.first{
            for iterator in self{
                if iterator != firstValue{
                    return false
                }
            }
            print ("winner \(self)")
            return true
        } else {
            return false
        }
    }
}
