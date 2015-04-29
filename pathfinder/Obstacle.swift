//
//  Obstacle.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: Element {
    var nextDir: Direction?
    
    init(position: (Int,Int)) {
        super.init(textureName: "obstacle", position: position)
        self.zPosition = CGFloat(2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // pickup an obstacle
    func obstaclePickedUp(heroDir: Direction?) -> () {
        // next Direction = Hero Direction
        nextDir = heroDir
    }
    
    func obstacleDropped() -> () {
        // next Direction = nil
        nextDir = nil
    }
    
    override func nextDirection() -> Direction? {
        return nextDir
    }
    
    // Element Methods
    override func isObstacle() -> Bool {
        return true
    }
}