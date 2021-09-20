//
//  ContentView.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var vm: SoundViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sound.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Sound>
    
    var body: some View {
        
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
            vm.playAudio()
        }, label: {
            if(!vm.isRecording){
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
        }
        )
        }
        
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
