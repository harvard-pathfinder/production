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
    var hero: Hero? = nil
    
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
        print("attack")
        // TODO: add animations here
    }
    
    // event firing
    override func move () -> () {
        self.events.trigger("move", information: nextDirection())
        if let hero1 = hero {
            if pos.0 == hero1.pos.0 && pos.1 == hero1.pos.1 {
                self.attackEvent(hero1)
            }
        }
    }
    
    // overrides nextDirection function
    override func nextDirection() -> Direction? {
        if let hero1 = hero {
            return naturalDirection(fromPoint: pos, toPoint: hero1.pos)
        }
        else {
            return nil
        }
    }
}
