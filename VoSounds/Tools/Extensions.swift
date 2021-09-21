//
//  Extensions.swift
//  VoSounds
//
//  Created by Student on 20.09.21.
//

import Foundation
import SwiftUI

extension Date {
    
    //Date to Milliseconds
    func toMilliseconds() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
        
    //From Milliseconds to Date
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
        self.addTimeInterval(TimeInterval(Double(milliseconds % 1000) / 1000 ))
    }
    
//    // Just any date
//    func getTemporaryDate() -> Date{
//        return Date(milliseconds: 437676767676)
//    }
    
    //Date to String of Milliseconds
    func toStringOfMilliseconds() -> String {
        return String(Int64(self.timeIntervalSince1970 * 1000))
    }

    
    //From String of Milliseconds to Date
    init(stringOfMilliseconds: String) {
        self = Date(timeIntervalSince1970: TimeInterval(Int64(stringOfMilliseconds)! / 1000))
        self.addTimeInterval(TimeInterval(Double(Int64(stringOfMilliseconds)! % 1000) / 1000 ))
    }
    
    var getCurentDateAsString: String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let currentDateStr = dateFormatter.string(from: self)
        return currentDateStr
        
    }
        
    var getCurentTimeAsString: String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        //Output: 12:16
      
        
        let currentDateStr = dateFormatter.string(from: self)
        /*  //if need time from String
        dateFormatter.dateFormat = "HH:mm:ss"
        Output: 12:16:45
        var dateFromStr = dateFormatter.date(from: "17:56:25")!
        */
        return currentDateStr
        
    }
    
    var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
        }

    var endOfDay: Date {
//        var components = DateComponents()
//        components.day = 1
//        components.second = -1
//        return Calendar.current.date(byAdding: components, to: startOfDay)!
        let calendar = Calendar.current
        let endTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
        return endTime
    }
}

