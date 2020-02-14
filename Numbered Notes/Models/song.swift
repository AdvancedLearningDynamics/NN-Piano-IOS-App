//
//  song.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 11/5/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import Foundation

struct Songs: Decodable {
    
    var filename: String
    var genre: String
    var filepath: String
    
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
