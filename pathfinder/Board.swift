//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

func contains (arr: [BoardNode], bNode: BoardNode) -> Bool {
    for node in arr {
        // if the node in the array and our node refer to same instance of BoardNode Object
        if bNode === node {
            return true
        }
    }
    // if there is no equality
    return false
}

class Board {
    // creates 2D array of arrays of BoardNodes
    var defaultBoard: [[[BoardNode]]] = BoardGenerator().defaultBoard()
    
    // return the path from one Position to another
    // will be implemented with A*
    func pathFromTo (from: BoardNode, to: BoardNode) -> [BoardNode] {
        return [BoardNode(x: 0, y: 0, elt: nil)]
    }
    
    // "gets" array of Bnodes at point p
    private func get (point p: (Int, Int)) -> [BoardNode] {
        let (x,y) = p
        return defaultBoard[x][y]
    }
    
    // "sets" array of BNodes at point p to be bNodes
    private func set (point p: (Int, Int), bNodes: [BoardNode]) -> () {
        let (x,y) = p
        defaultBoard[x][y] = bNodes
        return
    }
    
    // "modifies" array of BNodes at point p with the function f
    private func modify (point p: (Int, Int), function f: ([BoardNode] -> [BoardNode])) -> () {
        self.set(point: p, bNodes: f(self.get(point: p)))
        return
    }
    
    // adds bNode to array of BNodes at point p
    func add (point p: (Int, Int), bNode: BoardNode) -> () {
        self.modify(point: p, function: {(var bNodeArray: [BoardNode]) -> [BoardNode] in
            if contains(bNodeArray, bNode) {
                return bNodeArray
            }
            else {
                bNodeArray.append(bNode)
                return bNodeArray
            }
        })
        
        return
    }
    
    // removes bNode at point b from array of BNodes
    func remove (point p: (Int, Int), bNode: BoardNode) -> () {
        self.modify(point: p, function: {(var bNodeArray: [BoardNode]) -> [BoardNode] in
            // filter out bNodes which are equal to bNode
            bNodeArray.filter({(node: BoardNode) -> Bool
                in node !== bNode
            })
        })
    }
    
}

