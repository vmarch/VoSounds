//
//  TeachAudio.swift
//  VoSounds
//
//  Created by Student on 21.09.21.
//

import Foundation

struct TeachAudio: Equatable, Identifiable{
    let id = UUID()
    let name: String 
    let author: String
    let filename: String
}
