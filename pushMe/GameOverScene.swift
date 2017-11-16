//
//  GameOverScene.swift
//  pushMe
//
//  Created by Cam Marshall on 11/16/17.
//  Copyright © 2017 Cam Marshall. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.black
        let message = "GAME OVER"
        let scoreMessage = "SCORE:"
        
        
        let label = SKLabelNode(fontNamed: "Arial")
        label.text = message
        label.fontColor = SKColor.white
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let label2 = SKLabelNode(fontNamed: "Arial")
        label2.text = scoreMessage
        label2.fontColor = SKColor.white
        label2.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2.5)
        
        addChild(label)
        addChild(label2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
}
