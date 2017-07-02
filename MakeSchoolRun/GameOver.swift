//
//  GameOver.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/25/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene {
    
    let scoreLabel = SKLabelNode()
    let currentCoinsLabel = SKLabelNode()
    let maxCoinsLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        scoreLabel.text = "Final Score: \(self.userData?.value(forKey: "score") ?? 0)"
        currentCoinsLabel.text = "Final Coins: \(self.userData?.value(forKey: "coins") ?? 0)"
        maxCoinsLabel.text = "All Time Coins: \(GlobalCoin.sharedInstance.coins)"
        
        scoreLabel.fontSize = 30
        currentCoinsLabel.fontSize = 30
        maxCoinsLabel.fontSize = 30
        
        scoreLabel.position = CGPoint(x: 0, y: -80)
        currentCoinsLabel.position = CGPoint(x: 0, y: 20)
        maxCoinsLabel.position = CGPoint(x: 0, y: 120)

        addChild(scoreLabel)
        addChild(currentCoinsLabel)
        addChild(maxCoinsLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if let name = touchedNode.name
        {
            if name == "ResetButton"
            {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                if let scene = GameScene(fileNamed:"GameScene") {
                    self.view?.presentScene(scene, transition:reveal)
                }
            }
        }
    }
}
