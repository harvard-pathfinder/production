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
    var path = [BoardNode]()
    
    override var damage: Int {
        return 50
    }
    override var invSpeed: Int {
        return 1
    }
    
    init(position: (Int,Int)) {
        super.init(nameOfTexture: "enemy1", position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // event trigger
    func attackEvent (hero : Hero) -> () {
        self.events.trigger("attack", information: hero)
        print("attack")
        self.gameOverEvent()
        // TODO: add animations here
    }
    
    // event trigger to boardScene to change to GameOverScene
    func gameOverEvent () -> (){
        self.events.trigger ("gameOver")
    }
    
    // event firing
    override func move () -> () {
        self.events.trigger("move", information: nextDirection())
        if let hero1 = hero {
            if pos.0 == hero1.pos.0 && pos.1 == hero1.pos.1 {
                self.attackEvent(hero1)
                self.gameOverEvent()
            }
        }
    }
    
    // overrides nextDirection function
    override func nextDirection() -> Direction? {
        if let hero1 = hero {
            if path.count > 0 {
                // calculate next direction of motion
                let next = naturalDirection(fromPoint: pos, toPoint: path[0].pos)
                //print(pos)
                //print(path[0].pos)
                if next == Direction.West {
                    print("hi")
                }
                path.removeAtIndex(0)
                // update path
                return next
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
}
