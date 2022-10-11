//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes: [String : Int] = ["soft": 3, "medium": 4, "hard": 7 ]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle?.lowercased()
        
        totalTime =  eggTimes[hardness!]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness?.capitalized
        player?.stop()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        }else{
            timer.invalidate()
            titleLabel.text = "DONE!"
            soundAlarm(soundName: "alarm_sound");
        }
    }
    
    func soundAlarm(soundName: String) -> Void{
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }

}
