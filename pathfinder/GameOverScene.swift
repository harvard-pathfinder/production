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
    let score = SKLabelNode(fontNamed: "Times New Roman")
    var survivalTime: Int
    
    init (time: Int, size: CGSize) {
        survivalTime = time
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        // gameOver button
        gameOver.text = "Game Over"
        gameOver.fontSize = 50
        gameOver.fontColor = UIColor.redColor()
        gameOver.position = CGPoint(x:CGRectGetMidX(self.frame), y:(CGRectGetMidY(self.frame) + 350));
        
        // set up the physical world to make GameOver node bounce
        self.physicsWorld.gravity = CGVectorMake(0, -7)
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: CGRect(x: 0,y: 250,
                          width: self.frame.size.width,height: self.frame.size.height))
        self.physicsBody = physicsBody
        
        gameOver.physicsBody = SKPhysicsBody(circleOfRadius: gameOver.frame.size.width/2)
        gameOver.physicsBody!.friction = 0.3
        gameOver.physicsBody!.restitution = 0.8
        gameOver.physicsBody!.mass = 0.5
        
        // score
        score.text = "Survival Time: " + String(survivalTime)
        score.fontSize = 20
        score.fontColor = UIColor.whiteColor()
        score.position = CGPoint(x:CGRectGetMidX(self.frame), y:340);

        
        
        // play agin button
        playAgainButton.text = "Play Again";
        playAgainButton.fontSize = 20
        playAgainButton.position = CGPoint(x:CGRectGetMidX(self.frame), y: 50);
        self.addChild(playAgainButton)
        self.addChild(gameOver)
        self.addChild(score)
    }
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            // if the user touches the play again button
            if nodeAtPoint(location) == playAgainButton {
                
                playAgainButton.fontColor = UIColor.redColor()
                
                // create a new scene
                var transition:SKTransition = SKTransition.fadeWithDuration(2)
                let skView = self.view as SKView!
                var scene = BoardScene(size: skView.bounds.size)
                
                // go to the new scene
                skView.presentScene(scene, transition: transition)
            }
        }
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
