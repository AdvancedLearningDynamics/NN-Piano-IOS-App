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
    var song: Song
    var skin: String
    var songIndex: Int
    
    init(_ song: Song, _ skin: String){
        self.song = song
        self.skin = skin
        self.songIndex = 0
    }
    
    func preload(withCompletion callback: () -> Void){
        
        do {
            for octave in 1...6 {
                for note in Notes.allCases {
                    let sound = "0\(octave)_\(note)"
                    let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                    let url: URL = URL(fileURLWithPath: path)
                    let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                }
                
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
            let notes = song.notes
            let currentNote = notes[songIndex]
            if(currentNote.notename == touchedNode.name! && songIndex+1 != song.notes.count){
                
                let octave: String = "0\(String(currentNote.octave))" // Default right now
                let note: String = touchedNode.name!
                let fileName = octave+"_"+note+".mp3"
                scene.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
                
                
                songIndex += 1
                let NoteToPlay: SKLabelNode? = scene.childNode(withName: "NoteToPlay") as? SKLabelNode
                NoteToPlay!.text = "\(self.song.notes[self.songIndex].notename)"
                let Lyrics: SKLabelNode? = scene.childNode(withName: "Lyrics") as! SKLabelNode
                Lyrics!.text = (self.song.lyrics[self.songIndex])
                if("\(self.song.notes[self.songIndex].notename)" == "R"){
                    self.songIndex+=1
                    NoteToPlay!.text = "\(self.song.notes[self.songIndex].notename)"
                }
            }
            
            else {
                let octave: String = "04" // Default right now
                let note: String = touchedNode.name!
                let fileName = octave+"_"+note+".mp3"
                scene.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
            }
            
            
        }
    }
}

