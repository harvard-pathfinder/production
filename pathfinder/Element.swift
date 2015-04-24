//
//  Element.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

// includes Players, Obstacles, and Flags
class Element: SKSpriteNode {
    var pos: (Int, Int)
    var invSpeed: Int {
        return 1
    }
    
    // event manager
    var events = EventManager()
    
    // initializer
    init (textureName: String, position: (Int,Int)) {
        pos = position
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: nil, size: texture.size())
    }
    
    // event firing
    func move () -> () {
        self.events.trigger("move", information: nextDirection())
    }
    
    // next direction of the object's motion
    func nextDirection () -> Direction? {
        return Direction.North
    }
    
    // allows us to see which subclass of element it is
    func isHero () -> Bool {
        return false
    }
    
    func isObstacle () -> Bool {
        return false
    }
    
    func isFlag () -> Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}