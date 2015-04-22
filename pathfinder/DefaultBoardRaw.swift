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
    
    // y is always greater than 0
    private func processRow (y: Int, w: Int, heroAtP: (Int,Int)?, enemiesAtP: [(Int,Int)]?, obstaclesAtP: [(Int, Int)]?, flagAtP: (Int,Int)?) -> [Int] {
        var returnArray = [Int]()
        for var i = 0; i < w; ++i {
            // check if hero
            if let hero = heroAtP {
                if hero.0 == i && hero.1 == y {
                    returnArray.append(1)
                }
            } else if let enemyArr = enemiesAtP {
                for enemy in enemyArr {
                    if enemy.0 == i && enemy.1 == y {
                        returnArray.append(2)
                        break
                    }
                }
            } else if let obsArr = obstaclesAtP {
                for obs in obsArr {
                    if obs.0 == i && obs.1 == y {
                        returnArray.append(3)
                        break
                    }
                }
            } else if let flag = flagAtP {
                if flag.0 == i && flag.1 == y {
                    returnArray.append(4)
                }
            } else {
                returnArray.append(0)
            }
        }
        return returnArray
    }
    
    // only allows 1 element at each point
    func privateGenerator (width: Int, height: Int, hero: (Int,Int)?, enemies: [(Int,Int)]?, obstacles: [(Int, Int)]?, flag: (Int,Int)?) -> [[Int]]? {
        
        var boardArray : [[Int]]?
        if width == 0 || height == 0 {
            return nil
        }
        else {
            for var indexY = 0; indexY < height; ++indexY {
                boardArray?.append(self.processRow(indexY, w: width, heroAtP: hero, enemiesAtP: enemies, obstaclesAtP: obstacles, flagAtP: flag))
            }
        }
        
        return boardArray
    }
    
    func getBoard () -> [[Int]] {
        return board
    }
}