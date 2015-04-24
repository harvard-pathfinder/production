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
    
    init(position: (Int,Int), dir: Direction?) {
        super.init(textureName: "bullet", position: position)
        direction = dir
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // direction of bullet
    override func nextDirection() -> Direction? {
        return direction
    }
}