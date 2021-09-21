//
//  ListPlayer.swift
//  VoSounds
//
//  Created by Student on 21.09.21.
//

import Foundation
import AVFoundation
import SwiftUI

class ListPlayerAction:NSObject, AVAudioPlayerDelegate{
    
    var audioPlayer : AVAudioPlayer!
    
    func startPlaying(currentRecordingAudio: URL) {
                let playSession = AVAudioSession.sharedInstance()
        
                do {
                    try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                } catch {
                    print("Playing failed in Device")
                }
        
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: currentRecordingAudio)
                    audioPlayer.delegate = self
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
        
//                    for i in 0..<recordingsList.count {
//                        if recordingsList[i].fileURL == url {
//                            recordingsList[i].isPlaying = true
//                        }
//                    }
        
                } catch {
                    print("Playing Failed")
                }
    }
    
    
    func stopPlaying() {
        
                audioPlayer.stop()
//
//                for i in 0..<recordingsList.count {
//                    if recordingsList[i].fileURL == url {
//                        recordingsList[i].isPlaying = false
//                    }
//                }
    }
}


struct ListPlayer: View{
   
    
    var listA: ListPlayerAction = ListPlayerAction()
    
    @Environment(\.presentationMode) var presentation
    var currentRecordingAudio: URL

    var body: some View {
        
        // Button Play/Pause Audio
        Button(action: {
            
            listA.stopPlaying()
            self.presentation.wrappedValue.dismiss()
            
        }, label: {
                Image(systemName: "pause.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(height: 60)
        }
        ).onAppear {
            listA.startPlaying(currentRecordingAudio: self.currentRecordingAudio
        )
            
        }
    }
}
