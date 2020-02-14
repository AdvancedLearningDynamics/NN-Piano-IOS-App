//
//  MainMenuViewController.swift
//  Numbered Notes
//
//  Created by McKlyde Lagnada on 10/29/19.
//  Copyright © 2019 AdvancedLearningDynamics. All rights reserved.
//

import UIKit
import os

class MainMenuViewController: UIViewController {
    
    var song: Song?
    var songs: [Songs] = []
    var theme: String = "classic"
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var songlistTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songlistTable.delegate = self
        self.songlistTable.dataSource = self

        os_log("Main menu loaded", log: OSLog.default, type: .info)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SoundManager.getSongList(withCompletion: {songs -> Void in
            self.songs = songs
            DispatchQueue.main.async {
                self.songlistTable.reloadData()
            }
            
        })
        
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let pianoview = segue.destination as! PianoViewController
        pianoview.pianoManager = Keyboard(song!, theme)
    }
    

    @IBAction func playClick(_ sender: UIButton) {
        print("button clicked!!")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songinfo = self.songs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCellTableViewCell
        cell.TitleLabel.text = songinfo.filename;
        cell.SongFileInfo = songinfo
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songinfo = self.songs[indexPath.row]
        SoundManager.getSong(song: songinfo.filepath, withCompletion: {song -> Void in
            self.song = song
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showPianoView", sender: self)
            }
        })
    }
}
