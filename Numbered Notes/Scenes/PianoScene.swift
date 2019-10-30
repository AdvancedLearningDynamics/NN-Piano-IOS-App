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
            let node : SKNode = self.atPoint(location)
            
//          TODO: Off load this to another class! 
            if node.name == "PianoKey1" {
//                First option
                self.run(pianoManager!.play("04", "C"))
                
                
                
/*              Second Option
                Issue: Adds nodes. BAD idea.
                 
                 
                let path:String = Bundle.main.path(forResource: "01_C", ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
                let audio = SKAudioNode(url: url)
                audio.isPositional = false
                audio.autoplayLooped = false
                self.addChild(audio)
                audio.run(SKAction.play())
*/
            }
            if node.name == "PianoKey2" {
                self.run(pianoManager!.play("04", "D"))
            }
            if node.name == "PianoKey3" {
                self.run(pianoManager!.play("04", "E"))
            }
            if node.name == "PianoKey4" {
                self.run(pianoManager!.play("04", "F"))
            }
            
            
            
        }
        
    
        
    }
    
    
    
}
