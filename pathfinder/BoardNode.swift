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
class BoardNode: SKSpriteNode {
    var pos: (x: Int, y: Int)
    // (array of elements) option
    var elements: [Element]?
    // event manager
    var events = EventManager()

    // the A* mapped direction
    var path = randomDirection()
    
    // H value for A*
    // distance from the node to target node
    var hValue = 0
    
    // movement cost
    // G value for A*
    var gValue: Int = 0
    
    // G + H
    // F value for A*
    var fValue = 0
    
    // parent for A*
    var parentNode: BoardNode? = nil
    
    // initializer
    init(x: Int, y: Int, var elts: [Element]?) {
        pos = (x,y)
        elements = elts
        let texture = SKTexture(imageNamed: "tile")
        super.init(texture: texture, color: nil, size: texture.size())
        
        // iterates through added elements and adds to Sprite Tree
        if let eltArray = elements {
            for elt in eltArray {
                self.addChild(elt)
                elt.anchorPoint = CGPointMake(0.0, 1.0)
            }
        }
    }
    
    // event trigger
   func testEvent () -> () {
        self.events.trigger("created", information: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}