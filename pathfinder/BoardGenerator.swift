//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class BoardGenerator {
    lazy var defaultBoard = DefaultBoardRaw().getBoard()
    
    // TODO: implement entropy
    func getRandomBoard() -> [[BoardNode]] {
        return defaultBoard
    }
} 