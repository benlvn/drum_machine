//
//  Model.swift
//  Beat Buddy Prototype
//
//  Created by Ben Levine on 1/3/17.
//  Copyright © 2017 Bennett Levine. All rights reserved.
//

import Foundation
import AVFoundation

class BeatBuddy {
    
    private var tempo = 120;
    private var measure = 0;
    private var beat = 0;
    private var sixteenth = 0;
    private var metronomeOn = false;
    private var recording = false;
    private var recordingEnded = false;

    
    private var fourMeasures = [ [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                                 [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                                 [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                                 [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ] ]
    
    func getTempo() -> Int {
        return tempo;
    }
    
    func setTempo(newTempo: Int) {
        tempo = newTempo
    }
    
    
    
    func getMeasure() -> Int {
        return measure
    }
    
    
    func incrementMeasure() {
        measure += 1
        if(measure > 3){
            measure = 0
            endRecording()
        }
    }
    
    func getBeat() -> Int {
        return beat
    }
    
    var player: AVPlayer! = AVPlayer(url: Bundle.main.url(forResource: "click", withExtension: "mp3")!)
    
    func incrementBeat() {
        player.play()
        player.seek(to: kCMTimeZero)
        beat += 1
        if(beat > 3){
            if recording {
                incrementMeasure()
            }
            beat = 0
        }
    }
    
    func getSixteenth() -> Int {
        return sixteenth
    }
    
    func incrementSixteenth() {
        sixteenth += 1
        if(sixteenth > 3){
            if recording {
                incrementBeat()
            }
            sixteenth = 0
        }
    }
    
    func metronomeIsOn() -> Bool {
        return metronomeOn
    }
    
    func startMetronome() {
        metronomeOn = true
        recordingEnded = false
    }
    
    func endMetronome() {
        metronomeOn = false
    }
    
    func isRecording() -> Bool {
        return recording
    }
    
    func startRecording(){
        recording = true
        fourMeasures = [ [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                         [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                         [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ],
                         [ [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0] ] ]
    }
    
    func endRecording() {
        metronomeOn = false
        recording = false
        recordingEnded = true;
        printMeasures()
    }
    
    func recordingHasEnded() -> Bool{
        return recordingEnded
    }
    
    func drumHit() {
        if recording {
            fourMeasures[measure][beat][sixteenth] = 1
        }
        printMeasures()
    }
    
    func printMeasures() {
        print(getMeasureString(measureNum: 0))
        print(getMeasureString(measureNum: 1))
        print(getMeasureString(measureNum: 2))
        print(getMeasureString(measureNum: 3))
    }
    
    func getMeasureString(measureNum: Int) -> String{
        let currentMeasure = fourMeasures[measureNum]
        
        var isFirstBeat = true
        
        var stringToReturn = "[ "
        for beat in currentMeasure {
            if isFirstBeat {
                isFirstBeat = false
            } else {
                stringToReturn += "| "
            }
            for sixteenth in beat {
                stringToReturn += "\(sixteenth) "
            }
            
        }
        
        stringToReturn += "]"
        
        return stringToReturn
    }
}
