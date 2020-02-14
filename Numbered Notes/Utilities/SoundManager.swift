//
//  SoundManager.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 11/5/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import Foundation
import os

class SoundManager {
    static let host: URL? = URL(string: "https://numberednotes.com/")
    
    static func getSongList(withCompletion: @escaping (([Songs]) -> Void)) -> Void {
        let songList: URL = URL(string: "Songs/metadata.json", relativeTo: self.host!)!
        
        
        let request = NSMutableURLRequest(url: songList)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                os_log("Error fetching song lists", log: OSLog.default, type: .error)
                return
            }
            let songs = try? JSONDecoder().decode([Songs].self, from: data)
            withCompletion(songs!)
        })
        
        dataTask.resume()
        
    }
    static func getSong(song songPath: String, withCompletion: @escaping ((Song) -> Void)) -> Void {
        let songEscaped = songPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let requestPath: URL = URL(string: songEscaped, relativeTo: self.host!)!
        
        let request = NSMutableURLRequest(url: requestPath)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                os_log("Error fetching song", log: OSLog.default, type: .error)
                return
            }
            let song = try? JSONDecoder().decode(Song.self, from: data)
            withCompletion(song!)
        })
        
        dataTask.resume()
        
        
        
    }
    
//    private static func convertToCSV(_ file: String) -> [String] {
//
//
//
//    }
    
    
}
