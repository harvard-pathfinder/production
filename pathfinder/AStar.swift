//
//  A*Map.swift
//  pathfinder
//
//  Created by Tester on 4/23/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class AStar {
    
    var openList = [BoardNode]()
    var closedList = [BoardNode]()
    
    func map(#board: Board, destination: (x: Int, y: Int)) -> () {
        board.iterBoardNodes(function: {
            (bNode: BoardNode) -> () in bNode.hValue = self.manhattenFormat(bNode, destination: (destination.x, destination.y))
        })
    }
    
    // calculates the H value of a BNode
    private func manhattenFormat (bNode: BoardNode, destination: (x: Int, y: Int)) -> Int {
        return abs(bNode.pos.x - destination.x) + abs(bNode.pos.y - destination.y)
    }
    
    // calculates the G Value of a BNode
    // gets movement costs of AdjacentNodes
    func movementCostsOfAdjacent(#board: Board, startPoint: (x: Int, y: Int)) -> () {
        if let startingBNode = board.getBNode(atPoint: startPoint) {
            for adjacentBNode in self.getAdjacent(board: board, toPoint: startingBNode.pos) {
                if let direction = naturalDirection(fromPoint: startingBNode.pos, toPoint: adjacentBNode.pos) {
                    switch direction {
                    // if horizontal/ vertical, movement cost is 10
                    case Direction.North, Direction.East, Direction.South, Direction.West: adjacentBNode.gValue = 10
                    // if diagnal, movement cost is 14
                    case Direction.NorthEast, Direction.SouthEast, Direction.SouthWest, Direction.NorthWest: adjacentBNode.gValue = 14
                    }
                }
            }
        }
    }
    
    // gets nodes adjacent to a give point
    func getAdjacent (#board: Board, toPoint: (x: Int, y: Int)) -> [BoardNode] {
        var returnArray = [BoardNode]()
        for var i = -1; i <= 1; ++i {
            for var i2 = -1; i2 <= 1; ++i2 {
                if let bNode = board.getBNode(atPoint: (toPoint.x + i, toPoint.y + i2)) {
                    if i != 0 || i2 != 0 {
                        returnArray.append(bNode)
                    }
                }
            }
        }
        return returnArray
    }
    
    // iterate on adjacent nodes 
    func iterAdjacents (#board: Board, toPoint: (x: Int, y: Int), function f: (BoardNode) -> ()) -> () {
        for adjacent in self.getAdjacent(board: board, toPoint: toPoint) {
            f(adjacent)
        }
    }
    
    // calculates the F value of a BNode
    func calculateFvalue (bNode: BoardNode) -> () {
        bNode.fValue = bNode.gValue + bNode.hValue
        print((bNode.hValue, bNode.gValue, bNode.fValue))
    }
    
    // gets bNode with minimum F value
    func getAdjWithLowestFValue (#board: Board, toPoint: (x: Int, y: Int)) -> BoardNode? {
        var returnBNode: BoardNode? = nil
        for adjacentBNode in getAdjacent(board: board, toPoint: toPoint) {
            if let bNode = returnBNode {
                if adjacentBNode.fValue < bNode.fValue {
                    returnBNode = adjacentBNode
                }
            } else {
                returnBNode = adjacentBNode
            }
        }
        return returnBNode
    }
    
    // changes the parent of each child
    func addParents (childArr: [BoardNode], parent: BoardNode) -> () {
        for child in childArr {
            child.parentNode = parent
        }
    }
    
    // add to a list
    private func addBNodeToArray (bNodeToAdd: BoardNode, var list: [BoardNode]) -> () {
        for bNode in list {
            if bNode === bNodeToAdd {
                return
            }
        }
        list.append(bNodeToAdd)
    }
   
    // add to the Closed List
    func addToClosedList (bNode: BoardNode) -> () {
        self.addBNodeToArray(bNode, list: closedList)
    }
    
    // add to the Open List
    func addToOpenList (bNode: BoardNode) -> () {
        self.addBNodeToArray(bNode, list: closedList)
    }
    
    // remove from the openList
    func removeFromOpenList (bNode: BoardNode) -> () {
        for var i = 0; i < openList.count; ++i {
            if openList[i] === bNode {
                openList.removeAtIndex(i)
            }
        }
    }
    
    // check is bNode is in the array
    private func bNodeExistsInArray (bNodeToCheck: BoardNode, bNodeArray: [BoardNode]) -> Bool {
        for member in bNodeArray {
            if member === bNodeToCheck {
                return true
            }
        }
        return false
    }
    
    // check if bNode is in the ClosedList
    func bNodeExistsInClosedList (bNodeToCheck: BoardNode) -> Bool {
        return self.bNodeExistsInArray(bNodeToCheck, bNodeArray: closedList)
    }
    
    // check if bNode is in the OpenList
    func bNodeExistsInOpenList (bNodeToCheck: BoardNode) -> Bool {
        return self.bNodeExistsInArray(bNodeToCheck, bNodeArray: openList)
    }
    
    // check if the bNode is int he i
//    func map (#board: Board, destination: (x: Int, y: Int)) -> () {
//        board.iterBoardNodes(function: {
//            (let node: BoardNode) -> () in
//            if let path = naturalDirection(fromPoint: node.pos, toPoint: destination) {
//                node.path = path
//            }
//        })
//    }
//    
    func displayMap (#board: Board) -> () {
        board.iterBoardNodes(function: {
            (let node: BoardNode) -> () in
            if node.hValue > 0 && node.hValue < 12 {
                let hVal = SKSpriteNode(imageNamed: String(node.hValue))
                hVal.anchorPoint = CGPointMake(-1, 1)
                node.addChild(hVal)
            }
//            let arrow = SKSpriteNode(imageNamed: "Arrow")
//            arrow.anchorPoint = CGPointMake(1.0, 0.5)
//            arrow.setScale(0.3)
//            arrow.zRotation = directionToCGFloat(direction: node.path)
//            node.addChild(arrow)
        })
    }
}