//
//  A*Map.swift
//  pathfinder
//
//  Created by Tester on 4/23/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class AStar {
    
    func map (#board: Board, destination: (x: Int, y: Int)) -> () {
        board.iterBoardNodes(function: {
            (let node: BoardNode) -> () in
            if let path = naturalDirection(fromPoint: node.pos, toPoint: destination) {
                node.path = path
            }
        })
    }
    
    func displayMap (#board: Board) -> () {
        board.iterBoardNodes(function: {
            (let node: BoardNode) -> () in
            let arrow = SKSpriteNode(imageNamed: "arrow")
            arrow.anchorPoint = CGPointMake(1.0, 0.5)
            arrow.setScale(0.3)
            arrow.zRotation = directionToCGFloat(direction: node.path)
            node.addChild(arrow)
        })
    }
}