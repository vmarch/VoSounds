//
//  SoundViewModel.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import Foundation
import AVFoundation
import CoreData

class SoundViewModel : NSObject,
                       ObservableObject ,
                        AVAudioPlayerDelegate{
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private var countOfAudio: Int = 1
    
    @Published var recordingsList = [Recording]()
    
    @Published var isRecording : Bool = false {
        didSet{
            recordingActions()
        }
    }
    
    @Published var recordingIsFinished : Bool = false
    
    private var currentRecordingAudio: URL? = nil
    @Published var isPlayingAudio : Bool = false
    @Published var showingPlayList: Bool = false
   
   // @Published var recordingsList = [Sound] ()
    
    
    override init(){
        super.init()
        fetchAllRecording()
        prepareToRecord()
    }
    
    func getPath()->URL{
        let pathName = path.appendingPathComponent("vosounds_\(Date().toStringOfMilliseconds()).m4a")
        currentRecordingAudio = pathName
        print("\(pathName)")
        return pathName
    }

    //======================================================================
    //========================== AUDIO RECORDER ============================
    //======================================================================
   
    func recordingActions(){
          if (isRecording) {
              startRecording()
          }else{
              stopRecording()
          }
      }
    
    func prepareToRecord(){
        let recordSettings:[String: AnyObject] = [
            AVFormatIDKey: kAudioFormatAppleLossless as AnyObject,
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue as AnyObject,
            AVEncoderBitRateKey : 320000 as AnyObject,
            AVNumberOfChannelsKey : 2 as AnyObject,
            AVSampleRateKey  : 44100.0 as AnyObject
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: getPath(), settings: recordSettings)
            audioRecorder.prepareToRecord()
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        //        do {
        //            try recordingSession.setCategory(.playAndRecord, mode: .default)
        //            try recordingSession.setActive(true)
        //        } catch {
        //            print("Cannot setup the Recording")
        //        }
        //
        recordingSession.requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Permission to record granted")
                //self.setSessionPlayAndRecord()
                self.audioRecorder.record()
            } else {
                print("Permission to record not granted")
            }
        })
    }
    
    func stopRecording(){
        audioRecorder.stop()
        fetchAllRecording()
    }
    
    func deleteRecording() {
        //
        //        do {
        //            try FileManager.default.removeItem(at: url)
        //        } catch {
        //            print("Can't delete")
        //        }
        //
        //        for i in 0..<recordingsList.count {
        //
        //            if recordingsList[i].fileURL == url {
        //                if recordingsList[i].isPlaying == true{
        //                    stopPlaying(url: recordingsList[i].fileURL)
        //                }
        //                recordingsList.remove(at: i)
        //
        //                break
        //            }
        //        }
    }
        
    //======================================================================
    //=========================== AUDIO PLAYER =============================
    //======================================================================
    
    func playOrStopAudio(){
        if(countOfAudio>0 && !isRecording && !isPlayingAudio){
            isPlayingAudio = true
            startPlaying()
        }else if(isPlayingAudio){
            stopPlaying()
            isPlayingAudio = false
        }
    }
        
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playOrStopAudio()
    }
 
        func fetchAllRecording(){
            recordingsList.removeAll()
            
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

            var ind = 0
            
            for i in directoryContents {
               
                
                recordingsList.append(Recording(name: "Record_\(ind)", fileURL : i, createdAt:getFileDate(for: i)))
                
                ind += 1
                
            }
            
       //     recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
            
            print("TTTTTTT>>>> \(recordingsList)")
            
        }
    
//
//    func fetchAllRecording(){
//        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
//
//                for i in directoryContents {
//                    recordingsList.append(Sound(id: 1, created: getFileDate(for: i), filename: i.lastPathComponent, name: i.deletingPathExtension().lastPathComponent ))
//                }
//
//        Sound(
//                recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
//
//    }

    func startPlaying() {
                let playSession = AVAudioSession.sharedInstance()
        
                do {
                    try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                } catch {
                    print("Playing failed in Device")
                }
        
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: currentRecordingAudio!)
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
    
    
    func deleteRecording(url : URL) {
        //
        //        do {
        //            try FileManager.default.removeItem(at: url)
        //        } catch {
        //            print("Can't delete")
        //        }
        //
        //        for i in 0..<recordingsList.count {
        //
        //            if recordingsList[i].fileURL == url {
        //                if recordingsList[i].isPlaying == true{
        //                    stopPlaying(url: recordingsList[i].fileURL)
        //                }
        //                recordingsList.remove(at: i)
        //
        //                break
        //            }
        //        }
    }
    
       func getFileDate(for file: URL) -> Date {
            if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
                let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
                return creationDate
            } else {
                return Date()
            }
        }
}
