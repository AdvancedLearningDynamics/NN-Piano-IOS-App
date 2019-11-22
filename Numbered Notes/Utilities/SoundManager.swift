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
            let tempFile = "{\"name\":\"Bingo\",\"title\":\"Bingo\",\"tempo\":\"80\",\"notes\":[{\"notename\":\"R\",\"octave\":4,\"timing\":\"/2.\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"A\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"A\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"F\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"F\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"F\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"E\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"D\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/4\"},{\"notename\":\"B\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"G\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"A\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"B\",\"octave\":3,\"timing\":\"/4\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/2\"},{\"notename\":\"C\",\"octave\":4,\"timing\":\"/2\"}],\"lyrics\":[\"\",\"There\",\"was\",\"a\",\"far-\",\"mer\",\"had\",\"a\",\"dog\",\"and\",\"Bin-\",\"go\",\"was\",\"his\",\"name,\",\"oh.\",\"B\",\"I\",\"N\",\"G\",\"O,\",\"B\",\"I\",\"N\",\"G\",\"O,\",\"B\",\"I\",\"N\",\"G\",\"O,\",\"and\",\"Bin-\",\"go\",\"was\",\"his\",\"name,\",\"oh.\"],\"video\":\"https://www.youtube.com/watch?v=9mmF8zOlh_g\",\"score\":\"https://www.pianolessons4children.com/sheetmusic/Bingo_C_Major.pdf\",\"key\":\"C(Mjr)\",\"timeSignature\":\"TS: 4/4\"}".data(using: .utf8)!
            let song = try? JSONDecoder().decode(Song.self, from: tempFile)
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
