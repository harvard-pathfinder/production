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
    
    // enemies in the board
    var enemies = [Enemy]()
    
    // hero in the board
    var hero: Hero? = nil
    
    // event manager
    var events = EventManager()
    
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
    
    // "gets" Bnode at point p
    func getBNode (atPoint p: (Int,Int)) -> BoardNode? {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            return gameBoard[p.1][p.0]
        }
        return nil
    }
    
    // "gets" EltArray at point p
    func getElt (atPoint p: (Int,Int)) -> [Element]? {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            return gameBoard[p.0][p.1].elements
        }
        return nil
    }
    
    // "sets" array of BNodes at point p to be bNode
    func setBNode (atPoint p: (Int, Int), bNode: BoardNode) -> () {
        if p.0 >= 0 && p.0 < widthOfBoard && p.1 >= 0 && p.1 < heightOfBoard {
            gameBoard[p.0][p.1] = bNode
        }
    }
    
    // performs a function on a BNode atpoint
    func modifyBNode (atPoint p: (Int, Int), function f: (BoardNode -> ())) -> () {
        if let bNode = self.getBNode(atPoint: p) {
            f(bNode)
        }
    }

    // if element is an enemy... adds enemy to gameBoard
    func addEnemyToGameBoard (element: Element) -> () {
        // if enemy, add to enemy array
        if let enemy = element as? Enemy {
            self.enemies.append(enemy)
        }
    }
    
    // if element is an enemt... remove enemy from gameBoard
    func removeEnemyFromGameBoard (element: Element) -> () {
        // if enemy, remove from enemy array
        if let enemy = element as? Enemy {
            for (var i = 0; i < self.enemies.count; ++i) {
                if self.enemies[i] === enemy {
                    self.enemies.removeAtIndex(i)
                }
            }
        }
    }
    
    // if element is a hero.. remove hero from gameboard
    func removeHeroGyroUpdates (element: Element) -> () {
        if let hero = element as? Hero {
            hero.motionManager.stopGyroUpdates()
        }
    }
    
    // adds element BNodes at point p
    // adds element to SKSprite Tree
    // adds enemy to gameBoard
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
                    // if enemy, add to enemy array
                    self.addEnemyToGameBoard(e)
                }
                else {
                    // adds element to SpriteKit Tree
                    currentBNode.addChild(e)
                    e.anchorPoint = CGPointMake(0.0, 1.0)
                    // adds element to datastructure
                    currentBNode.elements! += [e]
                    // update pos in element
                    e.pos = currentBNode.pos
                    // if enemy, add to enemy array
                    self.addEnemyToGameBoard(e)
                }
            }
        )
    }
    
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
    
    // removes element from boardNode
    // removes element from SpriteTree
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
                                // if enemy, remove from enemy array
                                self.removeEnemyFromGameBoard(eltToRemove)
                                // if hero, stop Gyro Updates
                                self.removeHeroGyroUpdates(eltToRemove)
                            }
                        }
                    }
                }
            )
        }
    }
    
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
        // if the location is inside the board, then add
        if p1.0 >= 0 && p1.0 < widthOfBoard && p1.1 >= 0 && p1.1 < heightOfBoard {
            self.addElement(atpoint: p1, eltToAdd: eltToCreate)
            self.listenToElement(eltToCreate)
            // adds player listeners
            if let player = eltToCreate as? Player {
                self.listenToPlayer(player)
                // add enemy to enemyArr inside bullet
                if let enemy = player as? Enemy {
                    if let hero1 = hero {
                        for bullet in hero1.bullets {
                            // add bullet to enemy array
                            bullet.enemies.append(enemy)
                            // add enemy listeners
                            bullet.events.listenTo("die", action: {
                                self.removeElement(atPoint: bullet.pos, eltToRemove: bullet)
                            })
                        }
                    }
                }
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
    
    // hero listener
    func listenToHero(hero: Hero) {
        hero.events.listenTo("shoot", action: { (information:Any?) -> () in
            if let bullet = information as? Bullet {
                self.createNewElement(atPoint: hero.pos, eltToCreate: bullet)
            }
        })
    }
    
}