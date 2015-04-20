//
//  BoardPosition.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

// Ints for now
class BoardNode: SKNode {
    var pos: (x: Int, y: Int)
    // (array of elements) option
    var elements: [Element]? = nil
    
    init(x: Int, y: Int, elts: [Element]?) {
        pos = (x,y)
        elements = elts
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}