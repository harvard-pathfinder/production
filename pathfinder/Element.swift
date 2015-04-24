//
//  Element.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

// includes Players, Obstacles, and Flags
class Element: SKSpriteNode {
    var pos: (Int, Int)
    var invSpeed: Int {
        return 1
    }
    
    // event manager
    var events = EventManager()
    
    // initializer
    init (textureName: String, position: (Int,Int)) {
        pos = position
        let texture = SKTexture(imageNamed: textureName)
        super.init(texture: texture, color: nil, size: texture.size())
    }
    
    //Doesn't work, but a decent representation of what we want
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == self {
                self.runAction(
                    SKAction.sequence(
                        [SKAction.fadeAlphaTo(0.25, duration: 0.05),
                            SKAction.fadeAlphaTo(0.75, duration: 0.3)]
                    )
                )
            }
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    // event firing
    func move () -> () {
        self.events.trigger("move", information: nextDirection())
    }
    
    // next direction of the object's motion
    func nextDirection () -> Direction? {
        return Direction.North
    }
    
    // allows us to see which subclass of element it is
    func isHero () -> Bool {
        return false
    }
    
    func isObstacle () -> Bool {
        return false
    }
    
    func isFlag () -> Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}