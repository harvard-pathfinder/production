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
    var intBoard = CustomBoard().getBoard()
    
    // returns a 2d array BoardNodes
    func defaultBoard() -> [[BoardNode]] {
        var col = 0
        var row = 0
        // row
        return intBoard.map({
            (let iList) -> [BoardNode] in
            // column
            let boardRow = iList.map({
                (let i) -> BoardNode in
                // Holder for column
                let colHolder = col
                col = col + 1
                // If there is a hero in a location
                if i == 1  {
                    return BoardNode(x: row, y: colHolder, elts: [Hero(position: (row,colHolder))])
                }
                else if i == 2 {
                    return BoardNode(x: row, y: colHolder, elts: [Enemy(position: (row,colHolder))])
                }
                else if i == 3 {
                    return BoardNode(x: row, y: colHolder, elts: [Obstacle(position: (row,colHolder))])
                }
                else if i == 4 {
                    return BoardNode(x: row, y: colHolder, elts: [Flag(position: (row,colHolder))])
                }
                    // If there is not an element in a location
                else {
                    return BoardNode(x: row, y: colHolder, elts: nil)
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
