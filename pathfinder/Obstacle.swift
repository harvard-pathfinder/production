//
//  Obstacle.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Obstacle: Element {
    // Element Methods
    override func isObstacle() -> Bool {
        return true
    }
}