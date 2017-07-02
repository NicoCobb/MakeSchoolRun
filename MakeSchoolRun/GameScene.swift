//
//  GameScene.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/11/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import SpriteKit

//MARK: ObjectNames
let PlayerCategoryName      = "Player"
let SpikeCategoryName       = "Spike"
let PlatformCategoryName    = "Platform"
let CoinCategoryName        = "Coin"

//MARK: PhysicsCategories
let PlayerCategory      :   UInt32 = 0x1 << 0
let SpikeCategory       :   UInt32 = 0x1 << 1
let PlatformCategory    :   UInt32 = 0x1 << 2
let CoinCategory        :   UInt32 = 0x1 << 3

class GameScene: SKScene {
    

    
    let cameraNode = SKCameraNode()
    let scoreLabel = SKLabelNode()
    let currentCoinsLabel = SKLabelNode()
    let maxCoinsLabel = SKLabelNode()
    let addObstaclePoint = SKSpriteNode()
    let deleteObstaclePoint = SKSpriteNode()
    let platformLength = 568
    
    var player = SKSpriteNode()
    var platformsAdded = 0
    
    var score = 0
    var currentCoins = 0
    var isPlayerGrounded = true
    
    //MARK: Setup
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //set physics delegate to self
        //MARK: ASSIGN_PHYSICS_DELEGATE
        physicsWorld.contactDelegate = self
        
        SelectNextSection()
        SelectNextSection()
        SelectNextSection()
        
        
        let sectionLength = platformLength * 2
        player = childNode(withName: PlayerCategoryName) as! SKSpriteNode
        player.physicsBody!.contactTestBitMask = SpikeCategory
        player.physicsBody!.contactTestBitMask += CoinCategory
        
        //set up camera
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        cameraNode.xScale = 2.0
        cameraNode.yScale = 2.0
        
        //set up score label
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 20
        scoreLabel.text = "Score: \(score)"
        cameraNode.addChild(scoreLabel)
        
        //set up coins label
        currentCoinsLabel.position = CGPoint(x: 0, y: 50)
        currentCoinsLabel.fontColor = .white
        currentCoinsLabel.fontSize = 20
        currentCoinsLabel.text = "Current Coins: \(currentCoins)"
        cameraNode.addChild(currentCoinsLabel)
        
        //set up max coins label with CoinSingleton
        maxCoinsLabel.position = CGPoint(x: 0, y: 100)
        maxCoinsLabel.fontColor = .white
        maxCoinsLabel.fontSize = 20
        maxCoinsLabel.text = "All Time Coins: \(GlobalCoin.sharedInstance.coins)"
        cameraNode.addChild(maxCoinsLabel)
        
        //set up generation and deletion points
        let addObstacleX = frame.origin.x - size.width/2 + CGFloat(sectionLength)
        let deleteObstacleX = frame.origin.x - size.width/2 - CGFloat(sectionLength)
        
        addObstaclePoint.position = CGPoint(x: addObstacleX, y: frame.origin.y)
        deleteObstaclePoint.position = CGPoint(x: deleteObstacleX, y: frame.origin.y)
        
        cameraNode.addChild(addObstaclePoint)
        cameraNode.addChild(deleteObstaclePoint)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        let touchLocation = touch!.location(in: self)
        if isPlayerGrounded {
            player.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 750.0))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        score += 10
        scoreLabel.text = "Score: \(score)"
        player.physicsBody!.velocity.dx = 200
        
        //continually adjust camera position
        if (player.position.x + size.width/2 > cameraNode.position.x && !cameraNode.hasActions()) {
            cameraNode.position.x = player.position.x + size.width/2
        }
        
        //game over if player falls too far below the screen
        if player.position.y < -size.height/2 {
            dieAndRestart()
        }
        
        //add new sections
        if player.position.x > CGFloat(platformLength)*2 * CGFloat(platformsAdded - 2) {
            print("next")
            scoreLabel.text = String(score)
            SelectNextSection()
        }
        
        if player.physicsBody!.velocity.dy < 1 && player.physicsBody!.velocity.dy > -1 {
            isPlayerGrounded = true
        } else {
            isPlayerGrounded = false
        }
        
        //make the jump feel better
        if player.physicsBody!.velocity.dy >= 0 {
            physicsWorld.gravity = CGVector(dx: 0, dy: -10)

        } else {
            physicsWorld.gravity =  CGVector(dx: 0, dy: -15)

        }

    }
    
    //MARK: LOSS_STATE
    
    func dieAndRestart() {
        GlobalCoin.sharedInstance.coins += currentCoins
        UserDefaults.standard.set(GlobalCoin.sharedInstance.coins, forKey: "coins")
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        if let scene = GameOver(fileNamed:"GameOver") {
            scene.userData = NSMutableDictionary()
            scene.userData?.setValue(score, forKey: "score")
            scene.userData?.setValue(currentCoins, forKey: "coins")
            self.view?.presentScene(scene, transition:reveal)
        }
        
    }
    
    func SelectNextSection() {
        let sectionLength:CGFloat = CGFloat(platformLength * 2)
        
        let choice = Int(arc4random_uniform(3))
        switch choice {
        case 0:
            let path = Bundle.main.path(forResource: "PlatformSetOne", ofType: "sks")
            let nextObstacle = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            nextObstacle.position = CGPoint(x: sectionLength * CGFloat(platformsAdded) - size.width/2, y: 0 - size.height/2)
            addChild(nextObstacle)
        case 1:
            let path = Bundle.main.path(forResource: "PlatformSetTwo", ofType: "sks")
            let nextObstacle = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            nextObstacle.position = CGPoint(x: sectionLength * CGFloat(platformsAdded) - size.width/2, y: 0 - size.height/2)
            addChild(nextObstacle)
        case 2:
            let path = Bundle.main.path(forResource: "PlatformSetThree", ofType: "sks")
            let nextObstacle = SKReferenceNode (url: NSURL (fileURLWithPath: path!) as URL)
            nextObstacle.position = CGPoint(x: sectionLength * CGFloat(platformsAdded) - size.width/2, y: 0 - size.height/2)
            addChild(nextObstacle)
        default:
            print("something went wrong")
        }
        
        platformsAdded += 1
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //this gets called automatically when two contacts begin contact with each other

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PlayerCategory && secondBody.categoryBitMask == CoinCategory {
            //when player hits a coin
            currentCoins += 1
            currentCoinsLabel.text = "Current Coins: \(currentCoins)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == PlayerCategory && secondBody.categoryBitMask == SpikeCategory {
            print("hit spike")
            //when player hits a spike
            dieAndRestart()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //this gets called automatically when two contacts end contact with each other
        
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//        
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
        
    }
}
