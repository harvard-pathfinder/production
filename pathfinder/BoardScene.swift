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
        
        func whatever (bNode: BoardNode) -> () {
            let node = SKSpriteNode(imageNamed: "none")
            node.position = CGPointMake(CGFloat(bNode.pos.x), CGFloat(bNode.pos.y))
            self.addChild(node)
        }
        gameBoard.mapGameBoard(whatever)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
    
    override func update(currentTime: CFTimeInterval) {
    }

}