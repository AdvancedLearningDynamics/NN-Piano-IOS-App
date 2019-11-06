//
//  PianoScene.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 10/29/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import SpriteKit
import GameplayKit
import os

class PianoScene: SKScene {
    var pianoManager: Keyboard?
    var pianokey1: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        os_log("PianoScene has loaded", log: OSLog.default, type: .info)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode : SKNode = self.atPoint(location)
            
            pianoManager!.play(touchedNode, self)
            
            
        }
        
    
        
    }
    
    
    
}
