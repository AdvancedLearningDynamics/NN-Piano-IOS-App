//
//  MusicDisplayManager.swift
//  Numbered Notes
//
//  Created by McKlyde on 12/3/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import UIKit
import SpriteKit

class MusicDisplayManager: NSObject {
    
    let notes: [Note]
    let lyrics: [String]
    let parentNode: SKNode
    let longestLyric: String
    let displayNumber: Bool
    var MaxNodeWidth: CGFloat?
    var LyricNode: [SKNode]
    
    static let notesToEnum = [
        "C#": Notes.CsDf,
        "D#": Notes.DsEf,
        "E#": Notes.F,
        "F#": Notes.FsGf,
        "G#": Notes.GsAf,
        "A#": Notes.AsBf,
        "B#": Notes.C,
        "C": Notes.C,
        "D": Notes.D,
        "E": Notes.E,
        "F": Notes.F,
        "G": Notes.G,
        "A": Notes.A,
        "B": Notes.B,
        "CsDf": Notes.CsDf,
        "DsEf": Notes.DsEf,
        "FsGf": Notes.FsGf,
        "GsAf": Notes.GsAf,
        "AsBf": Notes.AsBf
    
    ]
    
    init(_ notes: [Note], _ lyrics: [String], _ parentNode: SKNode, displayNumber: Bool){
        self.notes = notes
        self.lyrics = lyrics
        self.parentNode = parentNode
        self.longestLyric = MusicDisplayManager.findMaxLength(lyrics)
        self.LyricNode = []
        self.displayNumber = displayNumber
    }
    
    
    func display() -> Void {
        createNodes()
        
        for node in LyricNode {
            self.parentNode.addChild(node)
        }
        optimizeNodes()
    }
    
    func displayNode(index: Int) -> Void {
        for i in 0..<LyricNode.count {
            LyricNode[i].position = CGPoint(x: CGFloat(i-index)*MaxNodeWidth!, y: 0)
            if(i == index){
                let note = LyricNode[i].childNode(withName: "Note") as! SKLabelNode
                note.fontColor = UIColor(displayP3Red: 205, green: 44, blue: 34, alpha: 1.0)
            } else {
                let note = LyricNode[i].childNode(withName: "Note") as! SKLabelNode
                note.fontColor = UIColor(displayP3Red: 205/100, green: 44, blue: 34, alpha: 1.0)
            }
        }
        optimizeNodes()
    }
    
    func optimizeNodes() -> Void {
//        Not Working
        for node in LyricNode {
            let nodePosX = node.position.x + parentNode.position.x
            if(nodePosX > 0 && nodePosX < 668){
                node.isHidden = false
            } else {
                node.isHidden = true
            }
        }
    }
    
    func createNodes() -> Void {
        
        let maxLyric: SKLabelNode = SKLabelNode(text: longestLyric)
        self.MaxNodeWidth = maxLyric.frame.size.width
        
        for i in 0..<lyrics.count {
            
            let node: SKNode = SKNode()
            var notename: String = self.notes[i].notename
            if(displayNumber){
                if(notename == "R" || (MusicDisplayManager.notesToEnum[notename]) == nil){
                    notename = "R"
                } else {
                    notename = (MusicDisplayManager.notesToEnum[notename])!.toString()
                }
            }
            let note: SKLabelNode = SKLabelNode(text: notename)
            let lyric: SKLabelNode = SKLabelNode(text: self.lyrics[i])
            
            note.position = CGPoint(x: 0, y: 30)
            note.name = "Note"
            
            lyric.position = CGPoint(x: 0, y: 0)
            lyric.name = "Lyric"
            
            node.addChild(note)
            node.addChild(lyric)
            
            
            node.position = CGPoint(x: CGFloat(i)*MaxNodeWidth!	, y:0)
            LyricNode.append(node)
            
        }
    }
    
    
    static private func findMaxLength(_ lyrics: [String]) -> String {
        var max: String = lyrics[0]
        for lyric in lyrics {
            if(lyric.count > max.count){
                max = lyric
            }
        }
        
        return max
    }
}
