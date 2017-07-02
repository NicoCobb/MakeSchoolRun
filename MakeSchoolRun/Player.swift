//
//  Player.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/18/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.physicsBody!.categoryBitMask = PlayerCategory
    }
}
