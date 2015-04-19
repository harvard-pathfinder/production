//
//  Hero.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Hero: Player {
    // instance variables
    override var damage: Int {
        return 50
    }
    override var invSpeed: Int {
        return 1
    }
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return nil
    }
}