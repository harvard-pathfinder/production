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
    func getBoard (#width: Int, height: Int) -> [[Int]] {
        return self.generator(width: width, height: height, hero: (2,3), enemies: [/*(1,1), (2,1)*/], obstacles: [(2,4), (1,1), (3,5), (2,5), (3,4)], flag: nil /*(2,2)*/)
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
    private func processRow (#currentHeight: Int, width: Int, heroAtP: (Int,Int)?, enemiesAtP: [(Int,Int)]?, obstaclesAtP: [(Int, Int)]?, flagAtP: (Int,Int)?) -> [Int] {
        var returnArray = [Int]()
        for var i = 0; i < width; ++i {
            if checkOption(heroAtP, currentP: (i, currentHeight)) {
                returnArray.append(1)
            }
            else if checkOptionArr(enemiesAtP, currentP: (i, currentHeight)) {
                returnArray.append(2)
            }
            else if checkOptionArr(obstaclesAtP, currentP: (i, currentHeight)) {
                returnArray.append(3)
            }
            else if checkOption(flagAtP, currentP: (i, currentHeight))
            {
                returnArray.append(4)
            }
            else
            {
                returnArray.append(0)
            }
        }
        return returnArray
    }
    
    // generates a board with integer representation of classes
    // only allows 1 element at each point
    private func generator (#width: Int, height: Int, hero: (Int,Int)?, enemies: [(Int,Int)]?, obstacles: [(Int, Int)]?, flag: (Int,Int)?) -> [[Int]] {
        
        var boardArray = [[Int]]()
        // invalid size
        if width == 0 || height == 0 {
            return boardArray
        }
        else {
            // iterates through the rows
            for var indexY = 0; indexY < height; ++indexY {
                boardArray.append(self.processRow(currentHeight: indexY, width: width, heroAtP: hero, enemiesAtP: enemies, obstaclesAtP: obstacles, flagAtP: flag))
            }
            return boardArray
        }
    }
}