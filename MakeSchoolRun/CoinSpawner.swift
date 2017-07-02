//
//  CoinSpawner.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/25/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit


class CoinSpawner: SKNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadCoin()
    }
    
    func loadCoin() {
        let choice = Int(arc4random_uniform(3))
        switch choice {
        case 0:
            return
        case 1:
            let path = Bundle.main.path(forResource: "Coin", ofType: "sks")
            let coin = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            addChild(coin)
        case 2:
            return
        default:
            print("something went wrong")
        }
    }
}
