//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit



class Board {
    // creates 2D array of arrays of BoardNodes
    private var gameBoard: [[BoardNode]] = BoardGenerator().defaultBoard()
    
    // event system
    var events = EventManager()
    
    // return the path from one Position to another
    // will be implemented with A*
    func pathFromTo (from: BoardNode, to: BoardNode) -> [BoardNode] {
        return [BoardNode(x: 0, y: 0, elts: nil)]
    }
    
    // CORRECT
    // apply a function to every BoardNode in the Board
    func iterBoardNodes (function f: (BoardNode -> ())) -> () {
        for row in gameBoard {
            for node in row {
                f(node)
            }
        }
    }
    
    func iterElements (function f: (Element -> ()), boardNode: BoardNode) -> () {
        if let eltArr = boardNode.elements {
            for elt in eltArr {
                f(elt)
            }
        }
    }
    
    // CORRECT
    // "gets" Bnode at point p
    func getBNode (atPoint p: (Int,Int)) -> BoardNode {
        return gameBoard[p.0][p.1]
    }
    
    // CORRECT
    // "gets" EltArray at point p
    func getElt (atPoint p: (Int,Int)) -> [Element]? {
        return gameBoard[p.0][p.1].elements
    }
    
    // CORRECT
    // "sets" array of BNodes at point p to be bNode
    func setBNode (atPoint p: (Int, Int), bNode: BoardNode) -> () {
        gameBoard[p.0][p.1] = bNode
    }
    
    // CORRECT
    // performs a function on a BNode atpoint
    func modifyBNode (atPoint p: (Int, Int), function f: (BoardNode -> ())) -> () {
        f(self.getBNode(atPoint: p))
    }
    
    // CORRECT
    // adds element BNodes at point p
    // adds element to SKSprite Tree
    func addElement (atpoint p: (Int, Int), eltToAdd e: Element) -> () {
        self.modifyBNode(atPoint: p,
            function: {(var currentBNode: BoardNode) -> () in
                if currentBNode.elements == nil {
                    // adds element to SpriteKit Tree
                    currentBNode.addChild(e)
                    e.anchorPoint = CGPointMake(0.0, 1.0)
                    // adds element to datastructure
                    currentBNode.elements = [e]
                    // update pos in element
                    e.pos = currentBNode.pos
                }
                else {
                    // adds element to SpriteKit Tree
                    currentBNode.addChild(e)
                    e.anchorPoint = CGPointMake(0.0, 1.0)
                    // adds element to datastructure
                    currentBNode.elements! += [e]
                    // update pos in element
                    e.pos = currentBNode.pos
                }
            }
        )
    }
    
    // CORRECT
    // removes element at point p
    func removeElement (atPoint p: (Int, Int), eltToRemove: Element) -> () {
        self.modifyBNode(atPoint: p,
            function: {(var currentBNode: BoardNode) -> () in
                if var elementArray = currentBNode.elements {
                    for (index, element) in enumerate(elementArray) {
                        if element === eltToRemove {
                            // removes element from SpriteKit Tree
                            eltToRemove.removeFromParent()
                            // removes element from datastructure
                            elementArray.removeAtIndex(index)
                            currentBNode.elements = elementArray
                        }
                    }
                }
            }
        )
    }
    
    // CORRECT
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
    
    // CORRECT
    // moves element from point 1 to point 2
    func moveElement (fromPoint p1: (Int, Int), toPoint p2: (Int, Int), eltToMove: Element) -> () {
        if self.elementExists(atPoint: p1, eltToCheck: eltToMove) {
            self.removeElement(atPoint: p1, eltToRemove: eltToMove)
            self.addElement(atpoint: p2, eltToAdd: eltToMove)
        }
    }
    
    
    // moves element from point 1 by a directional
    func moveElementByDirection (fromPoint p1: (Int,Int), toDirection direction: Direction, eltToMove: Element) -> () {
        if self.elementExists(atPoint: p1, eltToCheck: eltToMove) {
            self.removeElement(atPoint: p1, eltToRemove: eltToMove)
            let p2 = movePoint(fromPoint: p1, direction)
            self.addElement(atpoint: p2, eltToAdd: eltToMove)
        }
    }
    
    // board node event listener
    func listenToBNode(node: BoardNode) {
        node.events.listenTo("created", action: {
            println("bishes")
        })
    }
    
    func listenToElement(elt: Element) {
        elt.events.listenTo("move", action: {
            println("movingday")
        })
    }
}