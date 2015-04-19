//
//  GameScene.swift
//  pathfinder
//
//  Created by Tester on 4/18/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    let startButton = SKLabelNode(fontNamed:"Times New Roman")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        startButton.text = "Start Pathfinder";
        startButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(startButton)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            // if the user touches the survival button, go to the survival explanation
            if nodeAtPoint(location) == startButton {
                
                // create a new scene
                var scene = BoardScene()
                let skView = self.view as SKView!
                scene.size = skView.bounds.size
                
                // go to the new scene
                skView.presentScene(scene)
            }
        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
