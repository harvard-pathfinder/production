//
//  Element.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

enum Direction {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

class Element: SKNode {
    var pos: (Int, Int)
    
    init (pos z: (Int,Int)) {
        pos = z
        super.init()
    }
    
    func move (invSpeed: Int, nextDirection: Direction?) -> () {
        // if the element does not move
        if nextDirection == nil || invSpeed == 0 {
            return
        }
        // update the position otherwise, Direction must contain a value
        else {
            let (x,y) =  pos;
            switch nextDirection! {
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}