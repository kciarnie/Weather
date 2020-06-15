//
//  HourlyWeather.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct DailyDataPoint: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var summary: String?
    var icon: DarkSky.Icon
    var precipIntensity: Double
    var precipProbability: Double?
    var precipType: String?
    var temperature: Double
    var apparentTemperature: Double?
    var dewPoint: Double?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var windBearing: Double?
    var cloudCover: Double?
    var uvIndex: Double?
    var visibility: Double?
    var ozone: Double?
    var sunriseTime: Date?
    var sunsetTime: Date?
    var temperatureHigh: Double?
    var temperatureLow: Double?
}

extension DailyDataPoint {
    func getHumidity() -> String {
        return "\(humidity?.percent().int() ?? 0) %"
    }
    
    func getPressure() -> String {
        return "\(pressure?.roundUp() ?? 0) hPA"
    }
}

extension Double {
    func windDirectionFromDegree() -> String {
        // Based on http://www.climate.umn.edu/snow_fence/components/winddirectionanddegreeswithouttable3.htm
        
        if (self > 326.25) || (self <= 56.25) { // NNW, N, NNE, NE
            return "↑"
        } else if (self > 56.25) && (self <= 146.25) { // ENE, E, ESE, SE
            return "→"
        } else if (self > 146.25) && (self <= 236.25) { // SSE, S, SSW, SW
            return "↓"
        } else if (self > 236.25) && (self <= 326.25) { // WSW, W, WNW, NW
            return "←"
        } else {
            return "x"
        }
    }
}
