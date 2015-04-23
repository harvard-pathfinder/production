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
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return Direction.North
    }
    // inflict damage on touch, fire die event if enemy has no health
    func getHit () -> () {
        func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
            
            for touch: AnyObject in touches {
                EnemyLife = EnemyLife - 5
                println("hi")
                if EnemyLife <= 0 {
                    // fire event
                    func testEnemy () -> () {
                        self.events.trigger("enemyDeath", information: pos)
                    }
                }
            }
        }
    }
}