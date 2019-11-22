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
            songPath[i] = "\(csvFile[i])\(names[i]).csv"
        }
    }
    
    
    
}

struct Song: Decodable {
    var name: String
    var title: String
    var tempo: String
    var notes: [Note]
    var lyrics: [String]
    var video: String
    var score: String
    var key: String
    var timeSignature: String
}

struct Note: Decodable {
    var notename: String
    var octave: Int
    var timing: String
}
