//
//  Movable.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/22/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Movable {
    // event manager
    var events = EventManager()
    
    // event firing
    func testMove () -> () {
        self.events.trigger("move", information: self)
    }
}