//
//  Platform.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/20/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit

class Platform: SKSpriteNode {

    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.physicsBody!.categoryBitMask = PlatformCategory
    }
}
