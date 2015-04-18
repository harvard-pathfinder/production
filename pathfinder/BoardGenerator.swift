//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

// Code creates the board elements here
class BoardGenerator {
    
    // 2D array of Ints
    lazy var intBoard = DefaultBoardRaw().getBoard()
    
    // returns a 2d array of BoardNodes
    func defaultBoard() -> [[BoardNode]] {
        var col = 0
        var row = 0
        return intBoard.map({
            (let iList) -> [BoardNode] in
            let boardRow = iList.map({
                (let i) -> BoardNode in
                // Holder for column
                let colHolder = col
                col = col + 1
                // If there is an element in a location
                if i > 0 {
                    return BoardNode(x: row, y: colHolder, elt: Element(pos: (row, colHolder)))
                }
                    // If there is not an element in a location
                else {
                    return BoardNode(x: row, y: colHolder, elt: nil)
                }
            })
            col = 0
            row = row + 1
            return boardRow
        })
    }
    
    // TODO: implement entropy
    func getRandomBoard() -> [[BoardNode]] {
        return defaultBoard()
    }
} 
