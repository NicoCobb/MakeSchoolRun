//
//  PlatformSet.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/25/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//


import UIKit
import SpriteKit

class PlatformSet: SKScene {
    var deletePoint = SKNode()
    static var instancesOfSelf = [PlatformSet]()
    
    override func didMove(to view: SKView) {
        deletePoint = parent!.childNode(withName: "deleteObstaclePoint")!
    }
    
    class func destroySelf(object:PlatformSet)
    {
        instancesOfSelf = instancesOfSelf.filter {
            $0 !== object
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.position.x < deletePoint.position.x {
            self.removeFromParent()
            PlatformSet.destroySelf(object: self)
        }
    }
    
    deinit {
        print("Destroying instance of PlatformSet")
    }
}
