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
    var precipIntensity: Double?
    var precipProbability: Double?
    var precipType: String?
    var temperature: Double?
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
    var sunriseTime: Double?
    var sunsetTime: Double?
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
    func windDegreesToDirection() -> String {
        // Based on http://www.climate.umn.edu/snow_fence/components/winddirectionandselfreeswithouttable3.htm
        if (self >= 360 && self <= 21) {
            return "N"
        } else if (self >= 22 && self <= 44) {
            return "NNE"
        } else if (self >= 45 && self <= 66) {
            return "NE"
        } else if (self >= 67 && self <= 89) {
            return "ENE"
        } else if (self >= 90 && self <= 111) {
            return "E"
        } else if (self >= 112 && self <= 134) {
            return "ESE"
        } else if (self >= 135 && self <= 156) {
            return "SE"
        } else if (self >= 157 && self <= 179) {
            return "SSE"
        } else if (self >= 180 && self <= 201) {
            return "S"
        } else if (self >= 202 && self <= 224) {
            return "SSW"
        } else if (self >= 225 && self <= 246) {
            return "SW"
        } else if (self >= 247 && self <= 269) {
            return "WSW"
        } else if (self >= 270 && self <= 291) {
            return "W"
        } else if (self >= 292 && self <= 314) {
            return "WNW"
        } else if (self >= 315 && self <= 336) {
            return "NW"
        } else if (self >= 337 && self <= 359) {
            return "NNW"
        } else {
            return ""
        }
    }
}
