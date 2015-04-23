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
    
    private func insertNodeToBoardScene (bNode: BoardNode) -> () {
        let max = (x: self.frame.maxX, y: self.frame.maxY)
        let offsetX = bNode.frame.width
        let offsetY = bNode.frame.height
        
        // TODO: make positions percentages or fractions, based on the length of the array - maybe a gameboard.width element
        // TODO: possibly override this position variable in the BoardNode Class
        bNode.position = CGPointMake(CGFloat(bNode.pos.x) * (offsetX + 1), CGFloat(max.y - CGFloat(bNode.pos.y) * (offsetY + 1)))
        bNode.anchorPoint = CGPointMake(0.0, 1.0)
        bNode.name = String(bNode.pos.x) + String(bNode.pos.y)
        self.addChild(bNode)
        
        // event handler for element events
        gameBoard.iterElements(function: insertElementEventsToBoardScene, boardNode: bNode)
        
        // event handler for bNode events
        // board node event handler
        gameBoard.listenToBNode(bNode)
        bNode.testEvent()
        
    }
    
    private func insertElementEventsToBoardScene (elt: Element) -> () {
        gameBoard.listenToElement(elt)
    }

    override func didMoveToView(view: SKView) {
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
    }
    
    
    // all of these below are tests that I commented out
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            
            if node is Element {
                var elt = node as? Element
                elt?.testMove()
                
            }
            else if node is BoardNode {
                let bnode = node as? BoardNode
                // adds a NEW element to the gameboard
                gameBoard.createNewElement(atPoint: bnode!.pos, eltToCreate: Enemy(position: bnode!.pos))
            }
                
            else if node is Enemy {
                let eNode = node as? Enemy
                gameBoard.listenToEnemy(eNode!)
                eNode!.getHit()
                }
            }
    }


     override func update(currentTime: CFTimeInterval) {
        if let a = self.childNodeWithName("11") {
            a.zRotation += 0.01
        }
    }
}