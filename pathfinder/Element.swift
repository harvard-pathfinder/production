//
//  Element.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit


// directional
enum Direction {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

// includes Players, Obstacles, and Flags
class Element: SKNode {
    var pos: (Int, Int)
    var invSpeed: Int {
        return 0
    }
    
    // initializer
    init (pos z: (Int,Int)) {
        pos = z
        super.init()
    }
    
    // TODO: make the change on the Board as well this only alters the variable inside Elemetn
        // SEE World_Object Line 32 from PSET 7 for how to do this
        // Essentially erase the object at its previous location and add it to its new location
        // Should be a quick fix
    // move the element around the board
    func move (invSpeed: Int) -> () {
        // if the element does not move
        if self.nextDirection() == nil || invSpeed == 0 {
            return
        }
        // update the position otherwise, Direction must contain a value
        else {
            let (x,y) =  pos;
            switch self.nextDirection()! {
            case Direction.North: pos = (x,y+1)
            case Direction.NorthEast: pos = (x+1,y+1)
            case Direction.East: pos = (x+1,y)
            case Direction.SouthEast: pos = (x+1,y-1)
            case Direction.South: pos = (x, y-1)
            case Direction.SouthWest: pos = (x-1, y-1)
            case Direction.West: pos = (x-1,y)
            case Direction.NorthWest: pos = (x-1, y+1)
            default : pos = (x,y)
            }
            return
        }
    }
    
    // allows us to decide which direction to travel
    // implemented similiar to pset7
    func nextDirection () -> Direction? {
        return nil
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