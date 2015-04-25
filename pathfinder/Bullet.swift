//
//  Bullet.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/23/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Bullet: Element {
    var direction: Direction?
    var enemies = [Enemy]()
    var damage = 100
    
    init(position: (Int,Int), dir: Direction?, enemyArr: [Enemy]) {
        super.init(textureName: "bullet", position: position)
        direction = dir
        enemies = enemyArr
    }
    
    // move function overriden
    override func move () -> () {
        self.events.trigger("move", information: nextDirection())
        // if the result of the motion puts the enemy and the bullet in the same location
        for enemy in enemies {
            print(enemy.pos)
            print(pos)
            if enemy.pos.0 == pos.0 && enemy.pos.1 == pos.1 {
                // fire event
                enemy.getHit(damage)
                self.hitTarget()
            }
        }
    }
    
    // TODO:need to add the event listeners to bullets inside of BoardScene!!1
    // removes the bullet from the map
    func hitTarget() -> () {
        self.events.trigger("die", information: self)
    }
    
    // event trigger
    func hitEnemy() -> () {
        for enemy in enemies {
            if enemy.pos.0 == pos.0 && enemy.pos.1 == pos.1 {
                // fire event
                enemy.getHit(damage)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // direction of bullet
    override func nextDirection() -> Direction? {
        return direction
    }
}