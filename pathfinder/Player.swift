//
//  Player.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

// includes Heroes, Enemies
class Player: Element {
    // instance variables
    var maxHealth = 100
    var life = 100
    var damage : Int {
        return 0
    }
    
    init (nameOfTexture: String) {
        super.init(textureName: nameOfTexture)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // attack function
    func attack() -> () {
        return
    }
    
    // die function
    func die() -> () {
        return
    }
    
    // regenerates health slowly
    func restoreHealth () -> () {
        if life < maxHealth {
            life = life + 1
            return
        }
        else {
            return
        }
    }
    
    // if hurt by opponent, reduce life by "damage"
    func hurt(damage x: Int) -> () {
        if life - x <= 0 {
            life = 0
            self.die()
        }
        else {
            life = life - x
        }
    }
}