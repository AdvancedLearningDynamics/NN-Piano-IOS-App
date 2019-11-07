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
    
    static func getSongList(withCompletion: @escaping ((Songs) -> Void)) -> Void {
        let songList: URL = URL(string: "Songs/Song%20Paths%20For%20App.csv", relativeTo: self.host!)!
        
        
        let request = NSMutableURLRequest(url: songList)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                os_log("Error fetching song lists", log: OSLog.default, type: .error)
                return
            }
            let SongList: [String] = String(decoding: data, as: UTF8.self).components(separatedBy: "\r")
            let songs: Songs = Songs.init(SongList)
            withCompletion(songs)
        })
        
        dataTask.resume()
        
    }
//    , withCompletion: @escaping ((Song) -> Void)
    static func getSong(song songPath: String) -> Void {
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
            let csvFile: String = String(decoding: data, as: UTF8.self)
            print(csvFile)
        })
        
        dataTask.resume()
        
        
        
    }
    
    
}
