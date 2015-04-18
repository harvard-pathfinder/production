//
//  DefaultMap.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation


// Stores the raw data for a game board, for now a 2D array
class DefaultBoardRaw {
    let board:[[BoardNode]] = [[BoardNode(x: 0, y: 0)]]
    
    func getBoard () -> [[BoardNode]] {
        return board
    }
}