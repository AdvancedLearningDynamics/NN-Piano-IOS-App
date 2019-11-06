//
//  Keyboard.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 10/29/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation
import os

class Keyboard {
    var sounds: [String]
    var skin: String
    
    
    init(_ sounds: [String], _ skin: String){
        self.sounds = sounds
        self.skin = skin
    }
    
    func preload(withCompletion callback: () -> Void){
        
        do {
            for sound in sounds {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        }
        catch {
            os_log("Error occurred.", log: OSLog.default, type: .error)
        }
        
//      TODO: Preload textures.
        
        callback()
        
        
        return
    }
    
    func play(_ touchedNode: SKNode, _ scene: SKScene) -> Void {
//      Create a soundManager file for more flexbility.
        if(touchedNode.parent?.name == "Keyboard"){
            let octave: String = "04" // Default right now
            let note: String = touchedNode.name!
            let fileName = octave+"_"+note+".mp3"
            scene.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
    }
}

