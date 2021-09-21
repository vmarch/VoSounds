//
//  Recording.swift
//  CO-Voice
//
//  Created by Mohammad Yasir on 13/02/21.
//

import Foundation

struct Recording : Equatable, Identifiable {
    
    let id = UUID()
    var name : String
    let fileURL : URL
    let createdAt : Date
}
