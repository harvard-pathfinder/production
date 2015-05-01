//
//  BoardScene.swift
//  pathfinder
//
//  Created by Tester on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class BoardScene: SKScene {
    let gameBoard = Board(heroArg: Hero(position: (5,8)))
    let cropNode = SKCropNode()
    let astar = AStar()
    let motionManager = CMMotionManager()
    var nextX = CGFloat(0.0)
    var ticker = 0
    var score = 0
    let scoreButton = SKLabelNode(fontNamed:"Times New Roman")
    //  var hero: Hero
    
    override init (size: CGSize) {
        //        hero = gameBoard.hero
        super.init(size: size)
    }
    
    private func insertNodeToBoardScene (bNode: BoardNode) -> () {
        // draw board to scale
        let max = (x: gameBoard.world.frame.maxX, y: gameBoard.world.frame.maxY)
        let min = (x: gameBoard.world.frame.minX, y: gameBoard.world.frame.minY)
        bNode.size.width = gameBoard.world.frame.width / (CGFloat(gameBoard.widthOfBoard))
        bNode.size.height = gameBoard.world.frame.height / (CGFloat(gameBoard.heightOfBoard))
        let offsetX = bNode.frame.width
        let offsetY = bNode.frame.height
        let h = bNode.pos.y
        let w = bNode.pos.x
        
        bNode.position = CGPointMake(min.x + (CGFloat(w) * (offsetX )), CGFloat(max.y - (CGFloat(h) * (offsetY))))
        bNode.anchorPoint = CGPointMake(0.0, 1.0)
        bNode.name = String(bNode.pos.x) + ", " + String(bNode.pos.y)
        gameBoard.world.addChild(bNode)
        
        // event handler for element events
        gameBoard.iterElements(function: insertElementToBoardScene, boardNode: bNode)
        
        // event handler for bNode events
        gameBoard.listenToBNode(bNode)
    }
    
    // called at initialization of the BoardScene
    private func insertElementToBoardScene (elt: Element) -> () {
    
        elt.size.width = gameBoard.world.frame.width / (CGFloat(gameBoard.widthOfBoard))
        elt.size.height = gameBoard.world.frame.height / (CGFloat(gameBoard.heightOfBoard))
        
        if let hero = elt as? Hero {
            // do not add the hero to the board
            // the hero is added at the start
            return
        }
        
        gameBoard.listenToElement(elt)
        // add listeners to the player class
        if let player = elt as? Player {
            gameBoard.listenToPlayer(player)
            // add listeners to the enemy class
            if let enemy = player as? Enemy {
                gameBoard.listenToEnemy(enemy)
                gameBoard.enemies.append(enemy)
                insertHeroArgumentToEnemy(enemy)
                listenToGameOverEventFromBoard()
            }
        }
            // add obstacles to the hero arr, create listener
        else if let obstacle = elt as? Obstacle {
            // add obstacle to hero's obstacle array
            gameBoard.hero.obstacles.append(obstacle)
        }
    }
    
    // passes the hero as an argument to the enemy
    private func insertHeroArgumentToEnemy (enemy: Enemy) -> () {
        enemy.hero = gameBoard.hero
    }
    
    // motion manager
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.size = CGSizeMake(view.bounds.size.width, view.bounds.size.height)
        self.addChild(scoreButton)
        
        gameBoard.world = SKShapeNode(rectOfSize: CGSizeMake(self.size.width, self.size.height))
        gameBoard.world.fillColor = SKColor.redColor()
        self.addChild(gameBoard.world)
        
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:{
                data, error in
                    if self.ticker == 5 || self.ticker == 10 || self.ticker == 15 || self.ticker == 19 {
                        if let dir = vectorToDirection(CGFloat(data.acceleration.x), CGFloat(data.acceleration.y), CGFloat(M_PI_4)) {
                            self.gameBoard.hero.direction = dir
                            //self.gameBoard.moveElementByDirection(fromPoint: self.gameBoard.hero.pos, toDirection: dir, eltToMove: self.gameBoard.hero)
                            self.gameBoard.hero.move()
                        }
                    }
                    ++self.ticker
                }
            )
        }
    }
    
    
    // shoot on touch
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            // on touch shoot gun
            gameBoard.hero.shootGun(gameBoard.enemies)
            let location = touch.locationInNode(gameBoard.world)
            let node = nodeAtPoint(location)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        //add to score every 3 times
        scoreButton.text = String(score)
        if ticker % 4 == 0 {
            score++
        }
        // shoot gun every tick
        for bullet in gameBoard.hero.bullets {
            bullet.move()
        }
        if ticker >= 30 {
            for enemy in gameBoard.enemies {
                enemy.move()
            }
            ticker = 0
        }
        ++ticker
        
        if let dir = gameBoard.hero.direction {
            gameBoard.hero.zRotation = directionToCGFloat(direction: dir)
        }
    }
    
    func listenToGameOverEventFromBoard() {
        gameBoard.events.listenTo("gameOverFromBoard", action: {
            // send to game over scene
            var transition:SKTransition = SKTransition.fadeWithDuration(1)
            let skView = self.view as SKView!
            var scene = GameOverScene(time: self.score, size: skView.bounds.size)
            skView.presentScene(scene, transition: transition)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


//    override func touchesMoved(touches: Set <NSObject>, withEvent event: UIEvent) {
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(gameBoard.world)
//            let previousLocation = touch.previousLocationInNode(gameBoard.world)
//            gameBoard.world.position.x += (location.x - previousLocation.x)
//            gameBoard.world.position.y += (location.y - previousLocation.y)
//            gameBoard.iterBoardNodes(function: {
//                (let node) -> () in
//                // Can do parallax scrolling with various multipliers if we want to
//                node.position.x += (location.x - previousLocation.x)
//                node.position.y += (location.y - previousLocation.y)
//            })
//        }
//    }
}