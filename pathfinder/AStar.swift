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
    var path = [BoardNode]()
    
    
    func displayMap (#board: Board) (width: CGFloat) (height: CGFloat)-> () {
        print(path)
        board.iterBoardNodes(function: {
            (let bnode: BoardNode) -> () in
            for node in self.path {
                if bnode === node {
                    let pathnode = SKSpriteNode(imageNamed: "A*")
                    pathnode.size = CGSizeMake(width, height)
                    pathnode.anchorPoint = CGPointMake(-0.1,1.1)
                    node.addChild(pathnode)
                }
            }
        })
        
        //        board.iterBoardNodes(function: {
        //
        ////            (let node: BoardNode) -> () in
        ////            if node.hValue > 0 && node.hValue < 12 {
        ////                let hVal = SKSpriteNode(imageNamed: String(node.hValue))
        ////                hVal.anchorPoint = CGPointMake(-1, 1)
        ////                node.addChild(hVal)
        ////            }
        ////            let arrow = SKSpriteNode(imageNamed: "Arrow")
        ////            arrow.anchorPoint = CGPointMake(1.0, 0.5)
        ////            arrow.setScale(0.3)
        ////            arrow.zRotation = directionToCGFloat(direction: node.path)
        ////            node.addChild(arrow)
        //        })
    }
    
    func pathfind(#board: Board, startNode: BoardNode, destinationNode: BoardNode) -> [BoardNode] {
        openList = [BoardNode]()
        closedList = [BoardNode]()
        path = [BoardNode]()
//        // reset the board each time ... this will need to be changed!!
//        board.iterBoardNodes(function: {(bNode) -> () in
//            bNode.gValue = 0
//            bNode.hValue = 0
//            bNode.fValue = 0 })
        // TODO: remove sprites
        
        if startNode === destinationNode {
            path = [BoardNode]()
            return [BoardNode]()
        }
        // map the HValues of the entire board (only needs to be done once)
        self.mapHValues(board: board, destination: destinationNode.pos)
        // recursively go through the map and find path
        path = algorithmHelper(board: board, startNode: startNode, destinationNode: destinationNode)
        return path
    }
    
    // recurisvely go through the board and map out F,G, H, and Parents
    private func algorithmHelper(#board: Board, startNode: BoardNode, destinationNode: BoardNode) -> [BoardNode] {
        // if iterAdjacentBool returns true, then we have reached the end destination
        if self.iterAdjacentsBool(board: board, toPoint: startNode.pos, function: { (bNode) -> (Bool) in
            if bNode.pos.x == destinationNode.pos.x && bNode.pos.y == destinationNode.pos.y {
                return true
            }
            else {
                // if adjacent node is not yet in the closed list
                if !self.bNodeExistsInClosedList(bNode) {
                    // calculates the gValue of moving to a node via the start node as a parent
                    let movementCost = self.movementCostOfAdjacent(startNode, adjacentNode: bNode)
                    let newMoveCost = startNode.gValue + movementCost
                    // if node is already in the open list, update or leave alone
                    if self.bNodeExistsInOpenList(bNode) {
                        // if there is a faster way to reach a node, update gValue, fValue and Parents
                        if newMoveCost < bNode.gValue {
                            bNode.gValue = newMoveCost
                            bNode.parentNode = startNode
                            self.calculateFvalue(bNode)
                        }
                    }
                    // if node is not yet in the open list
                    else {
                        // only visit BoardNodes that are "empty"
                        if bNode.elements == nil {
                            self.addBNodeToOpenList(bNode)
                            bNode.gValue = newMoveCost
                            bNode.parentNode = startNode
                            self.calculateFvalue(bNode)
                        }
                    }
                }
                
                // add startNode to ClosedList, remove from OpenList
                self.removeFromOpenList(startNode)
                self.addBNodeToClosedList(startNode)
                
                // the destination is not adjacent, return false
                return false
            }
        }) {
            // base case: get the first move by going up the path
            print("here")
            return self.getPath(currentNode: startNode, path: [destinationNode])
        }
            // otherwise continue with the recursion
        else {
            // get OpenList member with lowest FValue
            let next = self.getOpenListMemberWithLowestFValue()
            print(next!.pos)
            return self.algorithmHelper(board: board, startNode: next!, destinationNode: destinationNode)
        }
    }
    
    // recursively moves up the list of parents to find which direction to move first
    private func getPath (#currentNode: BoardNode, path: [BoardNode]) -> [BoardNode] {
        // if there is (Some parent), continue searching
        if let parent = currentNode.parentNode {
            // creates a newPath with the closest to start node as head
            var newPath: [BoardNode] = [currentNode]
            // append old path to the back of newPath
            newPath += path
            return getPath(currentNode: parent, path: newPath)
        }
            // if there is an empty optional, we have reached the start
        else {
            // base case
            return path
        }
    }
    
    // maps the HValues of each individual node
    func mapHValues(#board: Board, destination: (x: Int, y: Int)) -> () {
        board.iterBoardNodes(function: {
            (bNode: BoardNode) -> () in bNode.hValue = self.manhattenFormat(bNode, destination: (destination.x, destination.y))
        })
    }
    
    // calculates the H value of a BNode
    private func manhattenFormat (bNode: BoardNode, destination: (x: Int, y: Int)) -> Int {
        return abs(bNode.pos.x - destination.x) + abs(bNode.pos.y - destination.y)
    }
    
    // calculates the movement cost of a given node
    private func movementCostOfAdjacent(startNode: BoardNode, adjacentNode: BoardNode) -> Int {
        if let direction = naturalDirection(fromPoint: startNode.pos, toPoint: adjacentNode.pos) {
            switch direction {
                // if horizontal/ vertical, movement cost is 10
            case Direction.North, Direction.East, Direction.South, Direction.West: return 10
                // if diagnal, movement cost is 14
            case Direction.NorthEast, Direction.SouthEast, Direction.SouthWest, Direction.NorthWest: return 14
            }
        }
        return 0
    }
    
    // gets movement costs of AdjacentNodes
    private func movementCostsOfAdjacents(#board: Board, startPoint: (x: Int, y: Int)) -> () {
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
    
    // calculates the F Values of Adjacent BNodes
    private func fValuesOfAdjacents(#board: Board, toPoint: (x:Int, y: Int)) -> () {
        iterAdjacents(board: board, toPoint: toPoint, function: self.calculateFvalue)
    }
    
    // gets nodes adjacent to a give point
    private func getAdjacent (#board: Board, toPoint: (x: Int, y: Int)) -> [BoardNode] {
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
    private func iterAdjacents (#board: Board, toPoint: (x: Int, y: Int), function f: (BoardNode) -> ()) -> () {
        for adjacent in self.getAdjacent(board: board, toPoint: toPoint) {
            f(adjacent)
        }
    }
    
    // iter adjacent nodes with a boolean return
    private func iterAdjacentsBool (#board: Board, toPoint: (x: Int, y: Int), function f: (BoardNode) -> (Bool)) -> (Bool) {
        for adjacent in self.getAdjacent(board: board, toPoint: toPoint) {
            if f(adjacent) {
                return true
            }
        }
        return false
    }
    
    // calculates the F value of a BNode
    private func calculateFvalue (bNode: BoardNode) -> () {
        bNode.fValue = bNode.gValue + bNode.hValue
    }
    
    // get open list memeber with min Fvalue
    private func getOpenListMemberWithLowestFValue () -> BoardNode? {
        var returnBNode: BoardNode? = nil
        for member in openList {
            if let bNode = returnBNode {
                if member.fValue < bNode.fValue {
                    returnBNode = member
                }
            }
            else {
                returnBNode = member
            }
        }
        return returnBNode
    }
    
    // changes the parent of each child
    private func addParents (childArr: [BoardNode], parent: BoardNode) -> () {
        for child in childArr {
            child.parentNode = parent
        }
    }
    
    // add to openList
    private func addBNodeToOpenList (bNodeToAdd: BoardNode) -> () {
        for bNode in openList {
            if bNode === bNodeToAdd {
                return
            }
        }
        openList.append(bNodeToAdd)
    }
    
    // add to closedList
    private func addBNodeToClosedList (bNodeToAdd: BoardNode) -> () {
        for bNode in closedList {
            if bNode === bNodeToAdd {
                return
            }
        }
        closedList.append(bNodeToAdd)
    }
    
    // remove from the openList
    private func removeFromOpenList (bNode: BoardNode) -> () {
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
    private func bNodeExistsInClosedList (bNodeToCheck: BoardNode) -> Bool {
        return self.bNodeExistsInArray(bNodeToCheck, bNodeArray: closedList)
    }
    
    // check if bNode is in the OpenList
    private func bNodeExistsInOpenList (bNodeToCheck: BoardNode) -> Bool {
        return self.bNodeExistsInArray(bNodeToCheck, bNodeArray: openList)
    }
    
}