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
    
    // Just any date
    func getTemporaryDate() -> Date{
        return Date(milliseconds: 437676767676)
    }
    
    //Date to String of Milliseconds
    func toStringOfMilliseconds() -> String {
        return String(Int64(self.timeIntervalSince1970 * 1000))
    }
   
    //From String of Milliseconds to Date
    init(stringOfMilliseconds: String) {
        self = Date(timeIntervalSince1970: TimeInterval(Int64(stringOfMilliseconds)! / 1000))
        self.addTimeInterval(TimeInterval(Double(Int64(stringOfMilliseconds)! % 1000) / 1000 ))
    }
    
    var getDateAsString: String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let dateAsString = dateFormatter.string(from: self)
        return dateAsString
        
    }
        
    var getCurrentTimeAsString: String{
        
        let dateFormatter = DateFormatter()
       // dateFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "MMM d, HH:mm:ss"
        //Output: Jan 1, 18:45:56
        
        /*
    
        dateFormatter.dateFormat = "HH:mm:ss"
        //Output: 12:16:45
         
        dateFormatter.dateFormat = "hh:mm:ss a 'on' MMMM dd, yyyy"
        //Output: 12:16:45 PM on January 01, 2000

        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        //Output: Sat, 1 Jan 2000 12:16:45 +0600

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //Output: 2000-01-01T12:16:45+0600

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        //Output: Saturday, Jan 1, 2000

        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        //Output: 01-01-2000 12:16

        dateFormatter.dateFormat = "MMM d, h:mm a"
        //Output: Jan 1, 12:16 PM

        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        //Output: 12:16:45.000

        dateFormatter.dateFormat = "MMM d, yyyy"
        //Output: Jan 1, 2000

        dateFormatter.dateFormat = "MM/dd/yyyy"
        //Output: 01/01/2000

        dateFormatter.dateFormat = "hh:mm:ss a"
        //Output: 12:16:45 PM

        dateFormatter.dateFormat = "MMMM yyyy"
        //Output: January 2000

        dateFormatter.dateFormat = "dd.MM.yy"
        //Output: 01.01.00
         
        dateFormatter.dateFormat = "dd.MM.yyyy"
        //Output: 01.01.2000

        //Customisable AP/PM symbols
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "Pm"
        dateFormatter.dateFormat = "a"
        //Output: Pm
        */
        
        let dateAsString = dateFormatter.string(from: self)
        /*  //if need time from String
        dateFormatter.dateFormat = "HH:mm:ss"
        Output: 12:16:45
        var dateFromStr = dateFormatter.date(from: "17:56:25")!
        */
        return dateAsString
        
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

