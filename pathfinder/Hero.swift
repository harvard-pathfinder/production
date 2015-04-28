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
    
    // obstacles on the map
    var obstacles = [Obstacle]()
    
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
    
    // tilt handler
    // TODO: process tilt data
    func tiltHandler() -> () {
        let rotation = motionManager.gyroData.rotationRate
//        if rotation.x > 1.0 && rotation.y > 1.0 {
//            direction = Direction.
//            self.move()
//        }
        
    }
    
    // move function
    override func move () -> () {
        self.events.trigger("move", information: nextDirection())
//        for obstacle in obstacles {
//            if obstacle.pos.0 == pos.0 && obstacle.pos.1 == pos.1 {
//                obstacle.obstaclePickedUp(self.nextDirection())
//            }
//        }
    }
    
    // die function
    override func dieEvent() -> () {
        self.events.trigger("die", information: self)
    }
    
    // fire the gun 
    func shootGun(enemies: [Enemy]) -> () {
        let bullet = Bullet(position: pos, dir: self.nextDirection(), enemyArr: enemies)
        self.events.trigger("shoot", information: bullet)
        bullets.append(bullet)
        print("shoot")
        // TODO: add animations here
    }
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return Direction.East
    }
}