//
//  Board.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation

class Board {
    var defaultBoard: [[BoardNode]] = BoardGenerator().defaultBoard()
    
    // return the path from one Position to another
    // will be implemented with A*
    func pathFromTo (from: BoardNode, to: BoardNode) -> [BoardNode] {
        return [BoardNode(x: 0, y: 0, elts: nil)]
    }
    
//    func set (point p: (Int, Int), (bNode: BoardNode) -> () {
//        defaultBoard[x].[y] =
//    }
//    func modify (point p: (Int, Int), function f: (BoardNode -> BoardNode)) {
//        
    }
}


//* Set a location in the world to contain a new list of objects. *)

//let set ((x,y):int*int) (wos:world_object_i list) : unit =

//world.(x).(y) <- wos

//(** Modify a location in the world with value os to contain (f os). *)
//48
//let modify (p:int*int) (f:world_object_i list -> world_object_i list) : unit =
//49
//set p (f (get p))
//50
//51
//(** Add an object to the list of world objects at a location. *)
//52
//let add (p:int*int) (w:world_object_i) : unit =
//53
//modify p (fun wos -> if List.mem w wos then wos else w::wos)
//54
//55
