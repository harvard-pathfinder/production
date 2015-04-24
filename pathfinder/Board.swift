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
    
    // height of the gameBoard
    var heightOfBoard: Int {
        return gameBoard.count
    }
    
    // width of the gameBoard
    var widthOfBoard: Int {
        return gameBoard[0].count
    }

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
    
    // iterates though a BoardNode's element array
    func iterElements (function f: (Element -> ()), boardNode: BoardNode) -> () {
        if let eltArr = boardNode.elements {
            for elt in eltArr {
                f(elt)
            }
        }
    }
    
    // CORRECT
    // "gets" Bnode at point p
    func getBNode (atPoint p: (Int,Int)) -> BoardNode? {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            return gameBoard[p.0][p.1]
        }
        return nil
    }
    
    // CORRECT
    // "gets" EltArray at point p
    func getElt (atPoint p: (Int,Int)) -> [Element]? {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            return gameBoard[p.0][p.1].elements
        }
        return nil
    }
    
    // CORRECT
    // "sets" array of BNodes at point p to be bNode
    func setBNode (atPoint p: (Int, Int), bNode: BoardNode) -> () {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            gameBoard[p.0][p.1] = bNode
        }
    }
    
    // CORRECT
    // performs a function on a BNode atpoint
    func modifyBNode (atPoint p: (Int, Int), function f: (BoardNode -> ())) -> () {
        if let bNode = self.getBNode(atPoint: p) {
            f(bNode)
        }
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
    // checks if element exists at point
    func elementExists (atPoint p: (Int, Int), eltToCheck: Element) -> Bool {
        if let bNode = self.getBNode(atPoint: p) {
            if let eltArray = bNode.elements {
                for elt in eltArray {
                    if elt === eltToCheck {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // CORRECT
    // removes element at point p
    func removeElement (atPoint p: (Int, Int), eltToRemove: Element) -> () {
        if elementExists(atPoint: p, eltToCheck: eltToRemove) {
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
    }
    
    // CORRECT
    // moves element from point 1 to point 2
    // returns an option tuple (the location of the element after the function call)
    func moveElement (fromPoint p1: (Int, Int), toPoint p2: (Int, Int), eltToMove: Element) -> ((Int,Int)?) {
        // if the destination is outside the bounds of the array
        if p2.0 < 0 || p2.0 >= widthOfBoard || p2.1 < 0 || p2.1 >= heightOfBoard {
            return p1
        }
        if self.elementExists(atPoint: p1, eltToCheck: eltToMove) {
            self.removeElement(atPoint: p1, eltToRemove: eltToMove)
            self.addElement(atpoint: p2, eltToAdd: eltToMove)
            return p2
        }
        return nil
    }
    
    
    // moves element from point 1 by a directional
    // returns an option tuple (the location of the element after the function call)
    func moveElementByDirection (fromPoint p1: (Int,Int), toDirection direction: Direction, eltToMove: Element) -> ((Int,Int)?) {
        if self.elementExists(atPoint: p1, eltToCheck: eltToMove) {
            // destination
            let p2 = movePoint(fromPoint: p1, direction)
            // if the destination is outside the bounds of the array
            //print(widthOfBoard)
            if p2.0 < 0 || p2.0 >= widthOfBoard || p2.1 < 0 || p2.1 >= heightOfBoard {
                return p1
            }
            // otherwise remove and add
            else {
                self.removeElement(atPoint: p1, eltToRemove: eltToMove)
                self.addElement(atpoint: p2, eltToAdd: eltToMove)
                return p2
            }
        }
        return nil
    }
    
    // adds a new element to the board for the first time 
    // initializes listeners
    func createNewElement (atPoint p1: (Int,Int), eltToCreate: Element) -> () {
        // if the location is insdie the array, just return
        print(p1)
        if p1.0 >= 0 && p1.0 < widthOfBoard && p1.1 >= 0 && p1.1 < heightOfBoard {
            self.addElement(atpoint: p1, eltToAdd: eltToCreate)
            self.listenToElement(eltToCreate)
            if eltToCreate is Player {
                let player = eltToCreate as? Player
                self.listenToPlayer(player!)
            }
        }
    }
    
    // board node event listener
    func listenToBNode(node: BoardNode) {
        node.events.listenTo("created", action: {
            // TODO: actions
        })
    }
    
    // element listener
    func listenToElement(elt: Element) {
        elt.events.listenTo("move", action: {
            if let nextDir = elt.nextDirection() {
                self.moveElementByDirection(fromPoint: elt.pos, toDirection: nextDir, eltToMove: elt)
            }
        })
    }
    
    // player listener
    func listenToPlayer(player: Player) {
        player.events.listenTo("die", action: {
            self.removeElement(atPoint: player.pos, eltToRemove: player);
        })
    }
    
}