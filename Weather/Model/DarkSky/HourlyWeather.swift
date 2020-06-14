//
//  HourlyWeather.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct HourlyWeather: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var temperature: Double
    var icon: DarkSky.Icon
    var summary: String?
    var precipProbability: Double?
    var dewPoint: Double?
    var humidity: Double?
    var pressure: Double?
}

extension HourlyWeather {
    func getHumidity(humidity: Double) -> String {
        return "\(humidity*100)%"
    }
    
    func getPressure() -> String {
        return "\(pressure ?? 0) hPA"
    }
}
