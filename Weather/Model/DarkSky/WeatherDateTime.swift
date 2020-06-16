//
//  WeatherDateTime.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 A class used to convert a unix timestamp with a timezone into a displayable Time string
 */
struct WeatherDateTime {
    let rawDate: Double
    let timeZone: TimeZone?
    
    /**
     The constructor
     
     - Parameter date: The date as a unix timestamp
     - Parameter timeZone: A timezone variable used to extract the timezone offset
     */
    init(date: Double, timeZone: TimeZone?) {
        self.timeZone = timeZone
        self.rawDate = date
    }
    
    /**
     Displays a timestamp as a time (ie. 5:00 PM)
     */
    func getShortTime() -> String {
        return convertDate("h:mm a")
    }
    
    /**
     Displays a timestamp as a day (ie. Monday, Tuesday....if the time is the next day, it will display Tomorrow)
     */
    func getDayString() -> String {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: rawDate)
        if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        return convertDate("EEEE")
    }
    
    /**
     Displays the timestamp as a date (ie. Tuesday,  16 June)
     */
    func getDayAndMonth() -> String {
        return convertDate("EEEE, d MMMM")
    }
    
    /**
     Converts the rawDate (unix timestamp) to a specific string based on the dateFormatter string
     
     - Parameter dateFormat: A string format representation of the output
     
     - Returns: a string representation based on the input parameter dateFormat

     */
    private func convertDate(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: self.rawDate)
        return dateFormatter.string(from: date)
    }
}
