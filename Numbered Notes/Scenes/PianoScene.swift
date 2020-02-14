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
    
    
    override func didMove(to view: SKView) {
        os_log("PianoScene has loaded", log: OSLog.default, type: .info)
        let LyricsDisplay: SKNode? = self.childNode(withName: "LyricsDisplay")
        var lyricsDisplayManager: MusicDisplayManager = MusicDisplayManager(pianoManager!.song.notes, pianoManager!.song.lyrics, LyricsDisplay!)
        pianoManager!.LyricDisplayManager = lyricsDisplayManager
        lyricsDisplayManager.display()
        pianoManager?.checkForRests();
        
        
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
