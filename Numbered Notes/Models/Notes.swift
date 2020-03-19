//
//  File.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 11/5/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

// TODO: handle all cases
enum Notes: Int, CaseIterable {
    case C = 1, CsDf, D, DsEf, E, F, G, FsGf, GsAf, A, AsBf, B
    
    func toString() -> String { return String(self.rawValue) }
}
