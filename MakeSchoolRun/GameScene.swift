//
//  GameScene.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/13/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        // add method that selects and places the next level scene piece
        // use SKActions to schedule these level pieces to come in at a set interval
        //
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // move the scenes from right to left
        // when a scene goes under a certain value on the x-axis, delete it
    }
}
