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
    
    var sounds: [String] = ["04_C","04_D","04_E","04_F"]
    var theme: String = "classic"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundManager.getSongList(withCompletion: {songs -> Void in
            SoundManager.getSong(song: songs.songPath[0])
        })

        os_log("Main menu loaded", log: OSLog.default, type: .info)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let pianoview = segue.destination as! PianoViewController
        pianoview.pianoManager = Keyboard(sounds, theme)
    }
    

    @IBAction func playClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showPianoView", sender: self)
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
