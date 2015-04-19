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
    
    // performs a function on a BNode atpoint
    func modifyBNode (atPoint p: (Int, Int), function f: (BoardNode -> ())) -> () {
        f(self.getBNode(atPoint: p))
    }
    
    // adds element BNodes at point p
    func addElement (atpoint p: (Int, Int), eltToAdd e: Element) -> () {
        self.modifyBNode(atPoint: p,
            function: {(var currentBNode: BoardNode) -> () in
                if currentBNode.elements == nil {
                    currentBNode.elements = [e]
                }
                else {
                    currentBNode.elements! += [e]
                }
            }
        )
    }
    
    // removes element at point p
    func removeElement (atPoint p: (Int, Int), eltToRemove: Element) -> () {
        self.modifyBNode(atPoint: p,
            function: {(var currentBNode: BoardNode) -> () in
                if var elementArray = currentBNode.elements {
                    for var index = 0; index < elementArray.count; ++index {
                        if elementArray[index] === eltToRemove {
                            elementArray.removeAtIndex(index)
                            currentBNode.elements = elementArray
                        }
                    }
                }
            }
        )
    }
    
    // checks if element exists at point
    func elementExists (atPoint p: (Int, Int), eltToCheck: Element) -> Bool {
        if let eltArray = self.getBNode(atPoint: p).elements {
            for elt in eltArray {
                if elt === eltToCheck {
                    return true
                }
            }
        }
        return false
    }
    
    // moves element from point 1 to point 2
    func moveElement (fromPoint p1: (Int, Int), toPoint p2: (Int, Int), eltToMove: Element) -> () {
        if self.elementExists(atPoint: p1, eltToCheck: eltToMove) {
            self.removeElement(atPoint: p1, eltToRemove: eltToMove)
            self.addElement(atpoint: p2, eltToAdd: eltToMove)
        }
        else {
            return
        }
    }
}



