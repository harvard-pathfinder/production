//
//  Obstacle.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Obstacle: Element {
    init(position: (Int,Int)) {
        super.init(textureName: "obstacle", position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Element Methods
    override func isObstacle() -> Bool {
        return true
    }
}