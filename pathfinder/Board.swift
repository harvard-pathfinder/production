//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Board {
    // creates 2D array of arrays of BoardNodes
    private var gameBoard: [[BoardNode]] = BoardGenerator().defaultBoard()
    
    // return the path from one Position to another
    // will be implemented with A*
    func pathFromTo (from: BoardNode, to: BoardNode) -> [BoardNode] {
        return [BoardNode(x: 0, y: 0, elts: nil)]
    }
    
    // "gets" Bnode at point p
     func getBNode (atPoint p: (Int, Int)) -> BoardNode {
        return gameBoard[p.0][p.1]
    }
    
    // "sets" array of BNodes at point p to be bNode
    func setBNode (atPoint p: (Int, Int), bNode: BoardNode) -> () {
        gameBoard[p.0][p.1] = bNode
    }
    
    // "modifies" array of BNodes at point p with the function f
    private func modify (point p: (Int, Int), function f: (BoardNode -> BoardNode)) -> () {
        gameBoard[p.0][p.1] = f(self.getBNode(atPoint: p))
    }
    
    // adds bNode to array of BNodes at point p
    func add (point p: (Int, Int), element e: Element) -> () {
        self.modify(point: p, function: {(var currentBNode: BoardNode -> BoardNode in
            if currentBNode.elements == nil {
                return currentBNode.elements = [e]
            }
            else {
                currentBNode.elements! += [e]
            }
            
        })
        return
    }
    
    // removes bNode at point b from array of BNodes
    func remove (point p: (Int, Int), bNode: BoardNode) -> () {
        self.modify(point: p, function: {(var curbNode: BoardNode) -> BoardNode in
            
    
        })
    }
}



