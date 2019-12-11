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
    var MaxNodeWidth: CGFloat?
    var LyricNode: [SKNode]
    
    init(_ notes: [Note], _ lyrics: [String], _ parentNode: SKNode){
        self.notes = notes
        self.lyrics = lyrics
        self.parentNode = parentNode
        self.longestLyric = MusicDisplayManager.findMaxLength(lyrics)
        self.LyricNode = []
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
                note.fontColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            } else {
                let note = LyricNode[i].childNode(withName: "Note") as! SKLabelNode
                note.fontColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
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
            let note: SKLabelNode = SKLabelNode(text: self.notes[i].notename)
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
