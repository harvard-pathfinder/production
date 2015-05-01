//
//  Direction.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit


// directional
enum Direction {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
}

// gives a random direction
func randomDirection () -> Direction {
    switch arc4random_uniform(7) {
    case 0: return Direction.North
    case 1: return Direction.NorthEast
    case 2: return Direction.East
    case 3: return Direction.SouthEast
    case 4: return Direction.South
    case 5: return Direction.SouthWest
    case 6: return Direction.West
    default: return Direction.NorthWest
    }
}

// changes a direction into a vector quantity
func directionToVector (dir: Direction?) -> (Int,Int) {
    if let d = dir {
        switch d {
        case Direction.North: return (0,-1)
        case Direction.NorthEast: return (1,-1)
        case Direction.East: return (1,0)
        case Direction.SouthEast: return (1,1)
        case Direction.South: return (0,1)
        case Direction.SouthWest: return (-1,1)
        case Direction.West: return (-1,0)
        case Direction.NorthWest: return (-1,-1)
        }
    }
    else {
            return (0,0)
    }
}

// moves a point from p1 by a direction
func movePoint (fromPoint p: (Int,Int), direction: Direction?) -> (Int, Int) {
    if let directionToMove = direction {
        let (x,y) = directionToVector(directionToMove)
        return(p.0 + x, p.1 + y)
    }
    else {
        return p
    }
}

// gets the natural direction between two points
func naturalDirection (fromPoint p1: (Int, Int), toPoint p2: (Int, Int)) -> Direction? {
    if p2.0 == p1.0 && p2.1 > p1.1 {
        return Direction.South
    } else if p2.0 > p1.0 && p2.1 > p1.1  {
        return Direction.SouthEast
    } else if p2.0 > p1.0 && p2.1 == p1.1 {
        return Direction.East
    } else if p2.0 > p1.0 && p2.1 < p1.1 {
        return Direction.NorthEast
    } else if p2.0 == p1.0 && p2.1 < p1.1 {
        return Direction.North
    } else if p2.0 < p1.0 && p2.1 < p1.1 {
        return Direction.NorthWest
    } else if p2.0 < p1.0 && p2.1 == p1.1 {
        return Direction.West
    } else if p2.0 < p1.0 && p2.1 > p1.1 {
        return Direction.SouthWest
    } else {
        return nil
    }
}

// move directly from one point to another without
func directPath (fromPoint p1: (Int, Int), toPoint p2: (Int,Int), var path: [(Int,Int)])-> [(Int,Int)] {
    if let dNatural = naturalDirection(fromPoint: p1, toPoint: p2) {
        // updates pArray to include next step
        path.append(movePoint(fromPoint: p1, dNatural))
        // recursive call to direct patj
        return directPath(fromPoint: (movePoint(fromPoint: p1, dNatural)), toPoint: p2, (path))
    }
    else {
        return path
    }
}

func vectorToDirection (x: CGFloat, y: CGFloat, max: CGFloat) -> Direction? {
    let xp = x/max
    let yp = y/max
    let tip = CGFloat(0.3)
    
    if xp > tip {
        if yp > tip {
            return Direction.NorthEast
        }
        else if yp < -tip {
            return Direction.SouthEast
        }
        else {
            return Direction.East
        }
    }
    else if xp < -tip {
        if yp > tip {
            return Direction.NorthWest
        }
        else if yp < -tip {
            return Direction.SouthWest
        }
        else {
            return Direction.West
        }
    }
    else if yp > tip {
        return Direction.North
    }
    else if yp < -tip {
        return Direction.South
    }
    else {
        return nil
    }
}

    // based on the unit circle, with east being 0
func directionToCGFloat (#direction: Direction) -> CGFloat {
    switch direction {
    case Direction.North: return dtr(90)
    case Direction.NorthEast: return dtr(45)
    case Direction.East: return dtr(0)
    case Direction.SouthEast: return dtr(315)
    case Direction.South: return dtr(270)
    case Direction.SouthWest: return dtr(225)
    case Direction.West: return dtr(180)
    case Direction.NorthWest: return dtr(135)
    }
}

// degrees to radians helper function
private func dtr (degrees: Int) -> CGFloat {
    return CGFloat(degrees) * CGFloat(M_PI / 180.0)
}










