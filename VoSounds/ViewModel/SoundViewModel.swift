//
//  SoundViewModel.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import Foundation
import AVFoundation
import CoreData

class SoundViewModel : NSObject, ObservableObject, AVAudioPlayerDelegate{
    
    //======= Teacher ========
    var teacherAudioPlayer : AVAudioPlayer!
    @Published var teacherAudioList:[TeachAudio] = []
    @Published var currentPlayingTeacherAudio: TeachAudio = TeachAudio(name: "", author: "", filename: "")
    @Published var isPlayingTeacherAudio : Bool = false
    
    @Published var showingTeacherPlayList: Bool = false
    
    //======= Student ========
    
    var audioRecorder : AVAudioRecorder!
    var studentAudioPlayer : AVAudioPlayer!
    
    @Published var studentRecordingList = [Recording]()
    @Published var currentPlayingStudentAudio: Recording = Recording(name: "", filename: "", created: "")
    @Published var isRecording : Bool = false
    @Published var recordingIsFinished : Bool = false
    
    @Published var isPlayingStudentAudio : Bool = false

    
    //======= Common =========
    var wordName: String = ""
    private let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    override init(){
        super.init()
        getWord()
        getPathToAudioRepository()
        fetchAllTeacherAudio()
        fetchAllStudentAudio()
        prepareToRecord()
    }
    
    //EXAMPLE OF WORD!!!
    
    func getWord(){
        wordName = "hannover"
    }
    
    
    
    
   func getPathToAudioRepository(){
     //  path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
//       let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//       let documentsDirectory = paths[0]
//       let docURL = URL(string: documentsDirectory)!
//       let dataPath = docURL.appendingPathComponent(wordName)
//
//       if !FileManager.default.fileExists(atPath: dataPath.path) {
//           do {
//               try  FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
//           } catch {
//               print(error.localizedDescription)
//           }
//       }
       
    }


    func getPath()->URL{
       
        let pathName = path.appendingPathComponent("vosounds_\(Date().toStringOfMilliseconds()).m4a")
        print("\(pathName)")
        
        return pathName
    }
    
    //======================================================================
    //========================== AUDIO RECORDER ============================
    //======================================================================
 
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
     
    func startOrStopRecording(){
        if(!isRecording && !isPlayingStudentAudio && !isPlayingTeacherAudio){
            isRecording = true
            startRecording()
        }else if(isRecording){
            stopRecording()
            isRecording = false
            fetchAllStudentAudio()
        }
    }
    
    
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
                do {
                    try recordingSession.setCategory(.playAndRecord, mode: .default)
                    try recordingSession.setActive(true)
                } catch {
                    print("Cannot setup the Recording")
                }
        
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
    }
    
    func deleteRecording() {
        //
        //        do {
        //            try FileManager.default.removeItem(at: url)
        //        } catch {
        //            print("Can't delete")
        //        }
        //
        //        for i in 0..<studentRecordingList.count {
        //
        //            if studentRecordingList[i].fileURL == url {
        //                if studentRecordingList[i].isPlaying == true{
        //                    stopPlaying(url: studentRecordingList[i].fileURL)
        //                }
        //                studentRecordingList.remove(at: i)
        //
        //                break
        //            }
        //        }
    }
    
    //======================================================================
    //======================= AUDIO PLAYER STUDENT==========================
    //======================================================================
    
    func fetchAllStudentAudio(){
        studentRecordingList.removeAll()
       
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        var ind = 0
        
        for i in directoryContents {
            studentRecordingList.append(Recording(name: "Record_\(ind)", filename: i.lastPathComponent, created: getFileDate(for: i).toStringOfMilliseconds()))
            ind += 1
            print("\(i.lastPathComponent)")
           }
        print("TTTTTTT>>>> \(studentRecordingList)")
    }
    
    func playOrStopStudentAudio(){
        if(studentRecordingList.count>0 && !isRecording && !isPlayingStudentAudio && !isPlayingTeacherAudio){
            isPlayingStudentAudio = true
            startPlayingStudentAudio()
        }else if(isPlayingStudentAudio){
            stopPlayingStudentAudio()
            isPlayingStudentAudio = false
        }
    }
    
    func startPlayingStudentAudio() {
            let playSession = AVAudioSession.sharedInstance()
        currentPlayingStudentAudio = studentRecordingList[(studentRecordingList.count - 1)]
            do {
                try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                print("Playing failed in Device")
            }
        print("Count: \(studentRecordingList.count)")
            do {
                studentAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:
                                                                        //TODO change to fool URL.
                                                                       currentPlayingStudentAudio))
                studentAudioPlayer.delegate = self
                studentAudioPlayer.prepareToPlay()
                studentAudioPlayer.play()
            } catch {
                print("Playing Failed")
            }
        }

    
    func stopPlayingStudentAudio() {
        studentAudioPlayer.stop()
    }
    

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlayingStudentAudio = false
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
    
    //======================================================================
    //======================== AUDIO PLAYER TEACHER ========================
    //======================================================================
   
    func  fetchAllTeacherAudio(){
           teacherAudioList.removeAll()
          
           let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
           
           var ind = 0
           
           for i in directoryContents {
               teacherAudioList.append(TeachAudio(name: "Teach_\(ind)", author: "Bob", filename: i.lastPathComponent))
               ind += 1
              }
           
        print("TTTTTTT>>>> \(teacherAudioList)")
           
       }
    
    func playOrStopTeacherAudio(){
        if(teacherAudioList.count > 0 && !isRecording && !isPlayingStudentAudio && !isPlayingTeacherAudio){
            
            startPlayingTeacherAudio()
            isPlayingTeacherAudio = true
        }else if(isPlayingTeacherAudio){
            stopPlayingTeacherAudio()
            isPlayingTeacherAudio = false
        }
    }
    
    func startPlayingTeacherAudio() {
        let playSession = AVAudioSession.sharedInstance()
        currentPlayingTeacherAudio = teacherAudioList[teacherAudioList.count-1]
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            teacherAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: currentPlayingTeacherAudio.filename))
            teacherAudioPlayer.delegate = self
            teacherAudioPlayer.prepareToPlay()
            teacherAudioPlayer.play()
        } catch {
            print("Playing Failed")
        }
    }
    
    func stopPlayingTeacherAudio() {
        if(isPlayingTeacherAudio){
            teacherAudioPlayer.stop()
        }
    }
}
