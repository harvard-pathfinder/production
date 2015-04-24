//
//  A*Map.swift
//  pathfinder
//
//  Created by Tester on 4/23/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class AStar {
    
    func map (#board: Board, destination: (x: Int, y: Int)) -> () {
        board.iterBoardNodes(function: {
            (let node: BoardNode) -> () in
                node.path = naturalDirection(fromPoint: node.pos, toPoint: destination)!
        })
    }
}