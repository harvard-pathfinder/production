//
//  GameOverScene.swift
//  pathfinder
//
//  Created by Sean Coleman on 4/27/15.
//  Copyright (c) 2015 harvard-pathfinder. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let gameOver = SKLabelNode (fontNamed:"Times New Roman")
    let playAgainButton = SKLabelNode(fontNamed:"Times New Roman")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameOver.text = "Game Over"
        gameOver.fontSize = 50
        gameOver.fontColor = UIColor.redColor()
        gameOver.position = CGPoint(x:CGRectGetMidX(self.frame), y:(CGRectGetMidY(self.frame) + 350));
        
        // set up the physical world to make GameOver node bounce
        self.physicsWorld.gravity = CGVectorMake(0, -7)
        // make it stop half way
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRect(x: 0,y: 200,
            width: self.frame.size.width,height: self.frame.size.height))
        self.physicsBody = physicsBody
        
        gameOver.physicsBody = SKPhysicsBody(circleOfRadius: gameOver.frame.size.width/2)
        gameOver.physicsBody!.friction = 0.3
        gameOver.physicsBody!.restitution = 0.8
        gameOver.physicsBody!.mass = 0.3
        
        playAgainButton.text = "Play Again";
        playAgainButton.fontSize = 20
        playAgainButton.position = CGPoint(x:CGRectGetMidX(self.frame), y: 50);
        self.addChild(playAgainButton)
        self.addChild(gameOver)
    }
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            // if the user touches the play again button
            if nodeAtPoint(location) == playAgainButton {
                
                // create a new scene
                let skView = self.view as SKView!
                var scene = BoardScene(size: skView.bounds.size)
                
                // go to the new scene
                skView.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
