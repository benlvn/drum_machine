//
//  ViewController.swift
//  Beat Buddy Prototype
//
//  Created by Ben Levine on 1/3/17.
//  Copyright © 2017 Bennett Levine. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var measure1: UILabel!
    @IBOutlet weak var measure2: UILabel!
    @IBOutlet weak var measure3: UILabel!
    @IBOutlet weak var measure4: UILabel!
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var tempoLabel: UILabel!
    
    private var model = BeatBuddy()
    private var sixteenthTimer: Timer?
    private var sixteenthTime: Double {
        get {
            return 1/Double(tempo)*60/4
        }
    }
    
    
    
    var tempo: Int {
        get {
            return model.getTempo()
        }
        set {
            tempoLabel.text = "\(newValue) bpm"
            
            model.setTempo(newTempo: newValue)
            
            if( newValue < 60){
                self.tempo = 60
            }
            
            if(newValue > 240){
                self.tempo = 240
            }
            
            tempoSlider.setValue(Float(newValue), animated: false)
            
            if model.metronomeIsOn() {
                new()
            }
        }
    }
    
    @IBAction func drumHit(_ sender: UIButton) {
        if(!model.isRecording() && model.metronomeIsOn()){
            model.startRecording()
        }
        if(model.isRecording()){
            model.drumHit()
        }

    }
    
    
    @IBAction func incrementTempo(_ sender: UIButton) {
        tempo += 1
    }
    
    
    @IBAction func decrementTempo(_ sender: UIButton) {
        tempo -= 1
    }
    
    func fireSixteenthTimer(timer: Timer){
        model.incrementSixteenth()
        if(model.recordingHasEnded()){
            timer.invalidate()
            measure1.text = model.getMeasureString(measureNum: 0)
            measure2.text = model.getMeasureString(measureNum: 0)
            measure3.text = model.getMeasureString(measureNum: 0)
            measure4.text = model.getMeasureString(measureNum: 0)
        } else {
            if(model.getSixteenth() == 0){

            }
        }
    }
    
    
    
    @IBAction func new() {
        sixteenthTimer?.invalidate()
        model.startMetronome()
        sixteenthTimer = Timer.scheduledTimer(withTimeInterval: sixteenthTime, repeats: true, block: fireSixteenthTimer)
        
    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        tempo = Int(sender.value)

    }
    
    
}

