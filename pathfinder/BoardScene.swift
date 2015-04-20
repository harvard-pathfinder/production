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
    
    override func didMoveToView(view: SKView) {
        
        func insertNode (bNode: BoardNode) -> () {
            let node = SKSpriteNode(imageNamed: "none")
            node.position = CGPointMake(CGFloat(bNode.pos.x * 10), CGFloat(bNode.pos.y * 10))
            self.addChild(node)
        }
        gameBoard.iterBoardNodes(function: insertNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func update(currentTime: CFTimeInterval) {
    }

}