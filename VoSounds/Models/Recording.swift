//
//  Recording.swift
//  CO-Voice
//
//  Created by Mohammad Yasir on 13/02/21.
//

import Foundation

struct Recording : Equatable, Identifiable {
    let id = UUID()
    let name : String
    let filename : String
    let created : String
}
