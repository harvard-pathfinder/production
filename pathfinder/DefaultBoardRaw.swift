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
            [0,0,0,0],
            [0,1,0,0],
            [0,0,0,0],
            [0,0,0,0]
        ]
    
    private func checkOption (optionP: (Int,Int)?, currentP: (Int,Int)) -> Bool {
        if let option = optionP {
            if option.0 == currentP.0 && option.1 == currentP.1 {
                return true
            }
        }
        return false
    }
    
    private func checkOptionArr (optionPArr: [(Int,Int)]?, currentP: (Int,Int)) -> Bool {
        if let pArr = optionPArr {
            for p in pArr {
                if p.0 == currentP.0 && p.1 == currentP.1 {
                    return true
                }
            }
        }
        return false
    }
    
    // y is always greater than 0
    private func processRow (y: Int, w: Int, heroAtP: (Int,Int)?, enemiesAtP: [(Int,Int)]?, obstaclesAtP: [(Int, Int)]?, flagAtP: (Int,Int)?) -> [Int] {
        var returnArray = [Int]()
        for var i = 0; i < w; ++i {
            if checkOption(heroAtP, currentP: (i,y)) {
                returnArray.append(1)
            }
            else if checkOptionArr(enemiesAtP, currentP: (i,y)) {
                returnArray.append(2)
            }
            else if checkOptionArr(obstaclesAtP, currentP: (i,y)) {
                returnArray.append(3)
            }
            else if checkOption(flagAtP, currentP: (i,y))
            {
                returnArray.append(4)
            }
            else
            {
                returnArray.append(0)
            }
        }
        print(returnArray)
        return returnArray
    }
    
    // generates a board with integer representation of classes
    // only allows 1 element at each point
    private func generator (width: Int, height: Int, hero: (Int,Int)?, enemies: [(Int,Int)]?, obstacles: [(Int, Int)]?, flag: (Int,Int)?) -> [[Int]] {
        
        var boardArray = [[Int]()]
        // invalid size
        if width == 0 || height == 0 {
            return boardArray
        }
        else {
            for var indexY = 0; indexY < height; ++indexY {
                boardArray.append(self.processRow(indexY, w: width, heroAtP: hero, enemiesAtP: enemies, obstaclesAtP: obstacles, flagAtP: flag))
                print(indexY)
            }
            return boardArray
        }
    }
    
    func getBoard () -> [[Int]] {
        return self.generator(5, height: 5, hero: (1,1), enemies: [(1,1), (2,1)], obstacles: [(2,4), (0,1)], flag: (2,2))
    }
}