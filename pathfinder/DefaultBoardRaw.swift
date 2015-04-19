//
//  DefaultMap.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation


// Stores the raw data for a game board, for now a 2D array
// Manually create the game board here
class DefaultBoardRaw {
    private let board:[[Int]] =
        [
            [1,1,1,1],
            [1,1,1,1],
            [1,1,1,1],
            [1,1,1,1]
        ]
    
    func getBoard () -> [[Int]] {
        return board
    }
}