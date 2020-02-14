//
//  PianoViewController.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 10/29/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import os

class PianoViewController: UIViewController {
    
    var pianoManager: Keyboard?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pianoManager!.preload(withCompletion:{
            () -> Void in
            os_log("Preloading assets complete.", log: OSLog.default, type: .info)
        })
        print(self.view?.window?.rootViewController)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = PianoScene(fileNamed: "PianoScene") {
                scene.pianoManager = self.pianoManager
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
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
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
