//
//  CustomBoard.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/22/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class CustomBoard {
    
    // update this function to create custom boards
    func getBoard () -> [[Int]] {
        return self.generator(5, height: 5, hero: (1,1), enemies: [(1,1), (2,1)], obstacles: [(2,4), (0,1)], flag: (2,2))
    }
    
    // helper function to evaluate options
    private func checkOption (optionP: (Int,Int)?, currentP: (Int,Int)) -> Bool {
        if let option = optionP {
            if option.0 == currentP.0 && option.1 == currentP.1 {
                return true
            }
        }
        return false
    }
    
    // helper function to evaluate options
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
    
    // processes a row
    // helper function for below
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
        //print(returnArray)
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
            // iterates through the rows
            for var indexY = 0; indexY < height; ++indexY {
                boardArray.append(self.processRow(indexY, w: width, heroAtP: hero, enemiesAtP: enemies, obstaclesAtP: obstacles, flagAtP: flag))
                //print(indexY)
            }
            return boardArray
        }
    }
}