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
    
    // obstacles on the map
    var obstacles = [Obstacle]()
    
    // bullets shot by the hero
    var bullets = [Bullet]()
    
    // direction variable
    var direction : Direction? = nil
    
    // intializes the gyro data
    init(position: (Int,Int)) {
        direction = Direction.East
        //source for the hero image on public domain
        //https://openclipart.org/detail/24566/simple-space-platform-game-stuff-6
        super.init(nameOfTexture: "hero1", position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // move function
    override func move () -> () {
        self.events.trigger("move", information: nextDirection())
    }
    
    // die function
    override func dieEvent() -> () {
        self.events.trigger("die", information: self)
    }
    
    // fire the gun 
    func shootGun(enemies: [Enemy]) -> () {
        if self.nextDirection() == nil {
            return
        }
        let bullet = Bullet(position: pos, dir: self.nextDirection(), enemyArr: enemies)
        self.events.trigger("shoot", information: bullet)
        bullets.append(bullet)
    }
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        let returnDirection: Direction? = direction 
        for obstacle in obstacles {
          // if obstacle in the way, do not move there!!
          let newPoint = movePoint(fromPoint: pos, returnDirection)
                if newPoint.0 == obstacle.pos.0 && newPoint.1 == obstacle.pos.1 {
                return nil
            }
        }
        return returnDirection
    }
}