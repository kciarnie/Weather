//
//  WeatherDateTime.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct WeatherDateTime {
    let rawDate: Double
    let timeZone: TimeZone?
    
    init(date: Double, timeZone: TimeZone?) {
        self.timeZone = timeZone
        self.rawDate = date
    }
    
    func getShortTime() -> String {
        return convertDate("h:mm a")
    }
    
    func getDayTime() -> String {
        return convertDate("EEEE, d MMMM")
    }
    
    private func convertDate(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: self.rawDate)
        return dateFormatter.string(from: date)
    }
}
