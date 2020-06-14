//
//  DarkSky.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct DarkSky: Codable {
    
    var current: HourlyWeather
    var hours: DarkSky.List<HourlyWeather>?
    var week: DarkSky.List<DailyWeather>?
    
    enum CodingKeys: String, CodingKey {
        
        case current = "currently"
        case hours = "hourly"
        case week = "daily"
    }
}
