//
//  GameViewController.swift
//  pushMe
//
//  Created by Cam Marshall on 11/16/17.
//  Copyright © 2017 Cam Marshall. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backgroundMusicPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                let bgMusicURL = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3")
                do {
                    try backgroundMusicPlayer = AVAudioPlayer(contentsOf: bgMusicURL!)
                }catch {
                    print("Cant Play Music")
                }
                
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
