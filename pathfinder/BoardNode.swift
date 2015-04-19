//
//  BoardPosition.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

// Ints for now
class BoardNode {
    var position: (Int,Int)
    // (array of elements) option
    var elements: [Element]? = nil
    
    init(x: Int, y: Int, elts: [Element]?) {
        position = (x,y)
        elements = elts
    }
}