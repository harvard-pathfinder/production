//
//  Hero.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class Hero: Player {
    // instance variables
    override var damage: Int {
        return 50
    }
    
    override var invSpeed: Int {
        return 1
    }
    
    // bullets shot by the hero
    var bullets = [Bullet]()
    
    // direction variable
    var direction : Direction? = nil
    
    // some help from http://nshipster.com/cmdevicemotion/ on this device motion
    // accelerometer
    var motionManager = CMMotionManager()
    
    // intializes the gyro data
    init(position: (Int,Int)) {
        super.init(nameOfTexture: "hero", position: position)
//        motionManager.gyroUpdateInterval = 0.1
//        if motionManager.gyroAvailable {
//            motionManager.startGyroUpdates()
//        }
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