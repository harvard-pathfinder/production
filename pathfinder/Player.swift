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
    
    init (nameOfTexture: String, position: (Int,Int)) {
        super.init(textureName: nameOfTexture, position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // attack function
    func attack() -> () {
        return
    }
    
    // die function
    func dieEvent() -> () {
        self.events.trigger("die", information: self)
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
    
    // inflict damage on touch, fire die event if enemy has no health
    func getHit (damage: Int) -> () {
        life = life - damage
        if life <= 0 {
            dieEvent()
        }
    }
}