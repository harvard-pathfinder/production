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
    
    // "gets" array of Bnodes at point p
     func get (point p: (Int, Int)) -> BoardNode {
        let (x,y) = p
        return gameBoard[x][y]
    }
    
    // "sets" array of BNodes at point p to be bNode
    func setBNode (atPoint p: (Int, Int), bNode: BoardNode) -> () {
        let (x,y) = p
        gameBoard[x][y] = bNode
        return
    }
    
    // performs a function on a BNode atpoint
    func modifyBNode (atPoint p: (Int, Int), function f: (BoardNode -> ())) -> () {
        f(self.get(point: p))
       
    }
    
    // adds element BNodes at point p
    func addElement (atpoint p: (Int, Int), element e: Element) -> () {
        self.modifyBNode(atPoint: p, function: {(var currentBNode: BoardNode) -> () in
            if currentBNode.elements == nil {
                currentBNode.elements = [e]
            }
            else {
                currentBNode.elements! += [e]
            }
            
        })
        return
    }
    
    // removes element at point b from array of BNodes
    func removeElement (atPoint p: (Int, Int), eltToRemove: Element) -> () {
        self.modifyBNode(atPoint: p, function: {(var currentBNode: BoardNode) -> () in
            if var elementArray = currentBNode.elements {
                for var index = 0; index < elementArray.count; ++index {
                    if elementArray[index] === eltToRemove {
                        elementArray.removeAtIndex(index)
                        currentBNode.elements = elementArray
                    }
                }
            }
        })
    }
}



