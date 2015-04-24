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
    let innerScene = SKSpriteNode()
    
    override init (size: CGSize) {
//        let innerScene = SKSpriteNode(imageNamed: "tile")
        super.init(size: size)
//        innerScene.anchorPoint = CGPointMake(0.5, 1.1)
//        innerScene.size.height = self.size.height / 2
//        innerScene.size.width = self.size.width * 0.90
//        innerScene.alpha = 0.5
//        innerScene.position.x = CGRectGetMidX(self.frame)
//        innerScene.position.y = CGRectGetMaxY(self.frame)
//        innerScene.name = "innerScene"
//        self.addChild(innerScene)
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
        //        println(innerScene.children)
    }
    
    private func insertNodeToBoardScene (bNode: BoardNode) -> () {
        //        let max = (x: innerScene.frame.maxX, y: innerScene.frame.maxY)
        let max = (x: self.frame.maxX, y: self.frame.maxY)
        bNode.size.width = self.frame.width / (1.4 * CGFloat(gameBoard.widthOfBoard))
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
        bNode.name = String(bNode.pos.x) + String(bNode.pos.y)
        //        innerScene.addChild(bNode)
        self.addChild(bNode)
        
        // event handler for element events
        gameBoard.iterElements(function: insertElementEventsToBoardScene, boardNode: bNode)
        
        // event handler for bNode events
        gameBoard.listenToBNode(bNode)
        bNode.testEvent()
    }
    
    private func insertElementEventsToBoardScene (elt: Element) -> () {
        gameBoard.listenToElement(elt)
        if let player = elt as? Player {
            gameBoard.listenToPlayer(player)
        }
    }
    
    override func didMoveToView(view: SKView) {
        //        println(innerScene.children)
    }
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            
            if node is Player {
                let player = node as? Player
                player!.getHit(100)
            }
            else if node is Element {
                print("here")
                let elt = node as? Element
                elt!.testMove()
                
            }
            else if node is BoardNode {
                let bnode = node as? BoardNode
                // adds a NEW element to the gameboard
                gameBoard.createNewElement(atPoint: bnode!.pos, eltToCreate: Enemy(position: bnode!.pos))
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let a = self.childNodeWithName("11") {
            a.zRotation += 0.01
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}