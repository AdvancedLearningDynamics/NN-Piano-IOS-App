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
    var displayNumber: Bool = false
    let character = SKSpriteNode(imageNamed: "tile000")
    var charAnimation: SKAction?
    
    override func didMove(to view: SKView) {
        
        var textures: [SKTexture] = []
         for i in 1...5 {
             textures.append(SKTexture(imageNamed: "tile00\(i)"))
         }
        print(textures)
        charAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
         
        character.position = CGPoint(x: 400, y: 240)
        character.zPosition = 100
        self.addChild(character)
        
        
        
        os_log("PianoScene has loaded", log: OSLog.default, type: .info)
        let LyricsDisplay: SKNode? = self.childNode(withName: "LyricsDisplay")
        var lyricsDisplayManager: MusicDisplayManager = MusicDisplayManager(pianoManager!.song.notes, pianoManager!.song.lyrics, LyricsDisplay!, displayNumber: self.displayNumber)
        pianoManager!.LyricDisplayManager = lyricsDisplayManager
        lyricsDisplayManager.display()
        pianoManager?.checkForRests();
        
        character.run(SKAction.repeatForever(charAnimation!))
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        

        
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode : SKNode = self.atPoint(location)
            
            if(touchedNode.name == "CloseButton"){
                self.removeFromParent()
                self.view?.window?.rootViewController?.dismiss(animated: false, completion: nil)
                return;
            }
            
            pianoManager!.play(touchedNode, self)
            
            
        }
        
    
        
    }
    
    
    
}
