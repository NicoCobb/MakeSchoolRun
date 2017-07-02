//
//  SpikeSpawner.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/25/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit


class SpikeSpawner: SKNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadSpike()
    }
    
    func loadSpike() {
        let path = Bundle.main.path(forResource: "Spike", ofType: "sks")
        let spike = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
        addChild(spike)
    }
}
