//
//  song.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 11/5/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import Foundation

struct Songs {
    
    var names: [String]
    var songPath: [String]
    
    init(_ csvFile: [String]) {
        names = Array(repeating: "null", count: csvFile.count)
        songPath = Array(repeating: "null", count: csvFile.count)
        
        
        for i in 0..<csvFile.count {
            let name = csvFile[i].components(separatedBy: "/")
            names[i] = name[name.count - 2]
            songPath[i] = csvFile[i]
        }
    }
    
    
    
}

struct Song {
    var name: String
    var title: String
    var tempo: Int
    var Notes: String
    var lyrics: String
//    var Cover: String  ?
//    var wav: String ?
//    var style: String ?
    var video: URL
    var score: URL
    var key: String
    var timeSignature: String
}
