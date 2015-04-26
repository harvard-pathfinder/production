//
//  A.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/26/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class A : Board {
    
    // map through the board
    func map (#board: Board, destination: (x: Int, y: Int)) -> () {
        board.iterBoardNodes(function: {
            (let node: BoardNode) -> () in
            if let path = naturalDirection(fromPoint: node.pos, toPoint: destination) {
                node.path = path
            }
        })
    }
}