//
//  ContentView.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var vm: SoundViewModel = SoundViewModel()
    
    var body: some View {
        
        VStack{
            HStack{
                // Button Start/Stop Record
                Button(action: {
                    vm.isRecording.toggle()
                }, label: {
                    if(vm.isRecording){
                        Image(systemName: "stop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(height: 60)
                    }else {
                        Image(systemName: "mic.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 60)
                    }
                }
                )
                
                // Button Play/Pause Audio
                Button(action: {
                    vm.playOrStopAudio()
                }, label: {
                    if(vm.isPlayingAudio){
                        Image(systemName: "pause.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 60)
                    }else{
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 60)
                    }
                }
                )
            }
            
            Button(action: {
                if self.vm.isRecording == true {
                    self.vm.stopRecording()
                }
                self.vm.fetchAllRecording()
                vm.showingPlayList.toggle()
            }) {
                Image(systemName: "list.bullet")
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold))
            }
            
            .sheet(isPresented: $vm.showingPlayList, content: {
                ListView(aRecords: $vm.recordingsList)
            })
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
