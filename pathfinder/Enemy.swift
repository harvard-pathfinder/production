//
//  Enemy.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/20/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: Player {
    // instance variables
    var EnemyLife = 25
    
    override var damage: Int {
        return 50
    }
    override var invSpeed: Int {
        return 1
    }
    
    init(position: (Int,Int)) {
        super.init(nameOfTexture: "enemy", position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // event trigger
    func attackEvent (hero : Hero) -> () {
        self.events.trigger("attack", information: hero)
    }
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return Direction.NorthEast
    }
}
