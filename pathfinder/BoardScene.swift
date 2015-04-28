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
    let gameBoard = Board(heroArg: Hero(position: (2,6)))
    let cropNode = SKCropNode()
    let astar = AStar()
    
    override init (size: CGSize) {
        super.init(size: size)
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
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
        // innerScene.addChild(bNode)
        self.addChild(bNode)
        
        // event handler for element events
        gameBoard.iterElements(function: insertElementToBoardScene, boardNode: bNode)
        
        // event handler for bNode events
        gameBoard.listenToBNode(bNode)
    }
    
    // called at initialization of the BoardScene
    private func insertElementToBoardScene (elt: Element) -> () {
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
    
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            // on touch shoot gun
            gameBoard.hero.shootGun(gameBoard.enemies)
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
        // shoot gun every tick
        for bullet in gameBoard.hero.bullets {
            bullet.move()
        }
        
        if ticker == 10 || ticker == 19 {
            for enemy in gameBoard.enemies {
                enemy.move()
            }
        } else if ticker == 20 {
            gameBoard.hero.move()
            ticker = 0
        }
        ++ticker
    }
    

//    // send to game over scene
//    var transition:SKTransition = SKTransition.fadeWithDuration(1)
//    let skView = self.view as SKView!
//    var scene = GameOverScene(size: skView.bounds.size)
//    skView.presentScene(scene, transition: transition)

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}