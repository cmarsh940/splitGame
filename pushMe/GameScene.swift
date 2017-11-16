//
//  GameScene.swift
//  pushMe
//
//  Created by Cam Marshall on 11/16/17.
//  Copyright © 2017 Cam Marshall. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:SKSpriteNode!
    var player2:SKSpriteNode!
    
    var initalPlayerPosition:CGPoint!
    
    var score = 0
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossivleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force/maximumPossivleForce
            
            player.position.x = (self.size.width / 2) - normalizedForce * (self.size.width/2 - 25)
            player2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width/2 - 25)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
    }
    
    func resetPlayerPosition() {
        player.position = initalPlayerPosition
        player2.position = initalPlayerPosition
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()
    }
    
    func addRandomRow () {
        let randomNumber = Int(arc4random_uniform(6))
        
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
    }
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithTimeSinceLastUpdate (timeSinceLastUpdate:CFTimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
            score = score+1
            print(score)
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" {
            print("GAME OVER")
            showGameOver()
        }
    }
    
    func showGameOver () {
        print("SCORE:", score)
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
}
