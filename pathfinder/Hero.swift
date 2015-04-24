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
    
    // bullets shot by the hero
    var bullets = [Bullet]()
    
    init(position: (Int,Int)) {
        super.init(nameOfTexture: "hero", position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shootGun() -> () {
        let bullet = Bullet(position: pos, dir: self.nextDirection())
        self.events.trigger("shoot", information: bullet)
        bullets.append(bullet)
    }
    
    // Element Methods
    // overrides NextDirection... will eventually be the accelerometer
    override func nextDirection() -> Direction? {
        return Direction.West
    }
}