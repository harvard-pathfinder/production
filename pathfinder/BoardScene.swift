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
        
        // TODO: make positions percentages or fractions, based on the length of the array - maybe a gameboard.width element
        bNode.position = CGPointMake(CGFloat(bNode.pos.x * 100), CGFloat(max.y - CGFloat(bNode.pos.y * 100)))
        bNode.anchorPoint = CGPointMake(0.0, 1.0)
        bNode.name = String(bNode.pos.x) + String(bNode.pos.y)
        self.addChild(bNode)
    }
    
    override func didMoveToView(view: SKView) {
        gameBoard.iterBoardNodes(function: insertNodeToBoardScene)
    }
    
    // all of these below are tests that I commented out
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let eltarray = gameBoard.getElt(atPoint: (1,1))
        gameBoard.moveElement(fromPoint: (1,1), toPoint: (2,2), eltToMove: eltarray![0])
    
//        let elt = Element()
//        if (gameBoard.elementExists(atPoint: (1,1), eltToCheck: elt)) {
//            print ("shoot")
//        }
//        else {
//            print ("google")
//        }        
//        let eltarray = gameBoard.getElt(atPoint: (1,1))
//        if (gameBoard.elementExists(atPoint: (1,1), eltToCheck: eltarray![0])) {
//            print("hi")
//        }
//        gameBoard.removeElement(atPoint: (1,1), eltToRemove: eltarray![0])
//        gameBoard.removeElement(atPoint: (1,1), eltToRemove: bnode.elements![0])
//        let elt = Element ()
//        let bnode =  BoardNode(x: 2, y: 2, elts: [elt])
//        self.insertNodeToBoardScene(bnode)
//        gameBoard.setBNode(atPoint: (2,2), bNode: bnode)
//        
//        gameBoard.iterBoardNodes(function:
//        {(bNode) -> () in bNode.position.x += CGFloat(1.0)})
//        gameBoard.addElement(atpoint: (2,3), eltToAdd: elt)
//        gameBoard.moveElement(fromPoint: (0,0), toPoint: (0,1), eltToMove: elt)
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let a = self.childNodeWithName("11") {
            a.zRotation += 0.01
        }
    }

}