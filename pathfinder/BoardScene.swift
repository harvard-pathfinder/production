//
//  BoardScene.swift
//  pathfinder
//
//  Created by Tester on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class BoardScene: SKScene {
    let gameBoard = Board()
    let cropNode = SKCropNode()
    let astar = AStar()
    
    override init (size: CGSize) {
        super.init(size: size)
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
        //        if let hero = self.childNodeWithName("hero") as? Element {
        //            astar.map(board: gameBoard, destination: hero.pos)
        //            astar.displayMap(board: gameBoard)
        //
        //astar.map(board: gameBoard, destination: (10,5))
        //astar.displayMap(board: gameBoard)
    }
    
    private func insertNodeToBoardScene (bNode: BoardNode) -> () {
        // let max = (x: innerScene.frame.maxX, y: innerScene.frame.maxY)
        let max = (x: self.frame.maxX, y: self.frame.maxY)
        bNode.size.width = self.frame.width / (CGFloat(gameBoard.widthOfBoard) / 1.5)
        //bNode.size.height = self.frame.height / (2 * CGFloat(gameBoard.heightOfBoard))
        // squares based on width for now
        bNode.size.height = bNode.size.width
        let offsetX = bNode.frame.width
        let offsetY = bNode.frame.height
        
        let h = bNode.pos.y
        let w = bNode.pos.x
        
        // TODO: make positions percentages or fractions, based on the length of the array - maybe a gameboard.width element
        // TODO: possibly override this position variable in the BoardNode Class
        // TODO: is this painting switched? height is width and vv
        bNode.position = CGPointMake(CGFloat(w) * (offsetX + 1), CGFloat(max.y - (CGFloat(h) * (offsetY + 1))))
        bNode.anchorPoint = CGPointMake(0.0, 1.0)
        bNode.name = String(bNode.pos.x) + ", " + String(bNode.pos.y)
        //        innerScene.addChild(bNode)
        self.addChild(bNode)
        
        // event handler for element events
        gameBoard.iterElements(function: insertElementToBoardScene, boardNode: bNode)
        
        // event handler for bNode events
        gameBoard.listenToBNode(bNode)
        bNode.testEvent()
    }
    
    // called at initialization of the BoardScene
    private func insertElementToBoardScene (elt: Element) -> () {
        gameBoard.listenToElement(elt)
        // add listeners to the player class
        if let player = elt as? Player {
            gameBoard.listenToPlayer(player)
            // add listeners to the enemy class
            if let enemy = player as? Enemy {
                gameBoard.listenToEnemy(enemy)
                gameBoard.enemies.append(enemy)
                insertHeroArgumentToEnemy(enemy)
            }
            // add listeners to the hero class
            if let hero = player as? Hero {
                gameBoard.listenToHero(hero)
                gameBoard.hero = hero
            }
        }
    }
    
    // passes the hero as an argument to the enemy
    private func insertHeroArgumentToEnemy (enemy: Enemy) -> () {
        if let hero = gameBoard.hero {
            enemy.hero = hero
        }
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            // on touch shoot gun
            if let hero = gameBoard.hero {
                // hero.shootGun(gameBoard.enemies)
                // displays the A* for debug purposes
                if let destination = gameBoard.getBNode(atPoint: hero.pos) {
                    let location = touch.locationInNode(self)
                    let node = nodeAtPoint(location)
                    if let bNode = node as? BoardNode {
                        print((bNode.pos, bNode.name))
                        astar.pathfind(board: gameBoard, startNode: bNode, destinationNode: destination)
                        astar.displayMap(board: gameBoard)
                    }
                }
            }
            
//            if node is Player {
//                let player = node as? Player
//                player!.getHit(100)
//            }
//                
//            else if node is BoardNode {
//                let bnode = node as? BoardNode
//                // adds a NEW element to the gameboard
//                gameBoard.createNewElement(atPoint: bnode!.pos, eltToCreate: Enemy(position: bnode!.pos))
//            }
        }
    }
    
    override func touchesMoved(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            gameBoard.iterBoardNodes(function: {
                (let node) -> () in
                // Can do parallax scrolling with various multipliers if we want to
                node.position.x += 1.3 * (location.x - previousLocation.x)
                node.position.y += 1.3 * (location.y - previousLocation.y)
            })
        }
    }
    
    var ticker = 0
    override func update(currentTime: CFTimeInterval) { 
        if ticker == 30 {
            for enemy in gameBoard.enemies {
                enemy.move()
            }
            if let hero = gameBoard.hero {
                for bullet in hero.bullets {
                    bullet.move()
                }
            }
            ticker = 0
        }
        ++ticker
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}