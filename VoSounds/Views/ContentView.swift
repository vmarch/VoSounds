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
   // @ObservedObject var vm: SoundViewModel = SoundViewModel()
    
    var body: some View {
        
        VStack{

            Section(header: Text("Choose an Teacher's Audio:")
                        .padding(.horizontal ,16)
                        .padding(.top ,8)){
                List{
                    ForEach(vm.teacherAudioList, id: \.id) { i in
                        HStack{
                            Text(i.name)
                                .fontWeight(.bold)
                        }
                    }
                }.padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 8)
                    .shadow(radius: 2)
            }
            
            Spacer()
            
            HStack{
                // Button Play/Pause Teacher's Audio
                Button(action: {
                    vm.playOrStopTeacherAudio()
                }, label: {
                    if(vm.isPlayingTeacherAudio){
                        Image(systemName: "speaker.wave.2.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 60)
                    }else{
                        Image(systemName: "speaker.wave.2.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(height: 60)
                    }
                }
                )
                Divider()
                // Button Start/Stop Record
                Button(action: {
                    vm.startOrStopRecording()
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
                
                // Button Play/Pause User's Audio
                Button(action: {
                    vm.playOrStopStudentAudio()
                }, label: {
                    if(vm.isPlayingStudentAudio){
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
            Divider()

            Section(header: Text("Choose your's Audio:")
                        .padding(.horizontal ,16)
                        .padding(.top ,8)){
                VStack{
                    List{
                        ForEach(vm.studentRecordingList, id: \.id) { (rec) in
                            NavigationLink(destination: Text("löl")) {
                                HStack{
                                                                  
                                Text("\(rec.name)")
                                    Text("(\(Date(stringOfMilliseconds: rec.created).getDateAsString)")
                                }.onAppear{
                                    print("IN LIST VIEW")
                                    
                                }
                            }
                        }
                    }.navigationBarItems(leading: EditButton(),
                                         trailing: Button("Add") {
                        
                    })
                }
            }
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
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
