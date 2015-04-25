//
//  Hero.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: Player {
    // instance variables
    override var damage: Int {
        return 50
    }
    
    override var invSpeed: Int {
        return 1
    }
    
    init(position: (Int,Int)) {
        super.init(nameOfTexture: "hero", position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // event firing
    override func move () -> () {
        self.events.trigger("move", information: nextDirection()
        )
        
    }

    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return Direction.North
    }
}