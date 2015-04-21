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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}