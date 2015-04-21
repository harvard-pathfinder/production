//
//  Flag.swift
//  pathfinder
//
//  Created by Robert Shaw on 4/19/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Flag: Element {
    // initializer
    init(position: (Int,Int)) {
        super.init(textureName: "flag", position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Element methods
    override func isFlag() -> Bool {
        return true
    }
    
}