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
    var LyricDisplayManager: MusicDisplayManager?
    
    
    static let equivalentNotes = [
        "C#": "CsDf",
        "D#": "DsEf",
        "E#": "F",
        "F#": "FsGf",
        "G#": "GsAf",
        "A#": "AsBf",
        "B#": "C",
        "C": "C",
        "D": "D",
        "E": "E",
        "F": "F",
        "G": "G",
        "A": "A",
        "B": "B",
        "CsDf": "CsDf",
        "DsEf": "DsEf",
        "FsGf": "FsGf",
        "GsAf": "GsAf",
        "AsBf": "AsBf"
    
    ]
    
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
    
    func next() {
        songIndex += 1
        LyricDisplayManager!.displayNode(index: songIndex)
    }
    
    func play(_ touchedNode: SKNode, _ scene: SKScene) -> Void {
//      Create a soundManager file for more flexbility.
        if(touchedNode.parent?.name == "Keyboard"){
            let notes = song.notes
            let currentNote = notes[songIndex]
            if(Keyboard.equivalentNotes[currentNote.notename] == touchedNode.name! && songIndex+1 != song.notes.count){
                
                
                let octave: String = "0\(String(currentNote.octave))" // Default right now
                let note: String = touchedNode.name!
                let fileName = octave+"_"+note+".mp3"
                scene.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
                
                next()
            }
            
            else {
//              If the note being played is incorrect, just play the note. Currently default is the 4th octave.
                let octave: String = "04" // Default right now
                let note: String = touchedNode.name!
                let fileName = octave+"_"+note+".mp3"
                scene.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
            }
            
            
        }
        checkForRests();
        
        
    }
    
    func checkForRests() -> Void {
        if(self.song.notes[songIndex].notename == "R" || self.song.notes[songIndex].notename == ""){
            next()
            checkForRests()
        }
        else {
            return
        }
    }
}

