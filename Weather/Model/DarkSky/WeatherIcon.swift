//
//  WeatherIcon.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
import UIKit

/**
 This extension converts the values like `clear-day` into a readable string value for the `weathericons-regular.ttf` font
 */
extension DarkSky {
    
    enum Icon: String, Codable {
        
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partyCloudyDay = "partly-cloudy-day"
        case partyCloudyNight = "partly-cloudy-night"
        case hail = "hail"
        case thunderstorm = "thunderstorm"
        case tornado = "tornado"

        var iconString: String {
            switch self {
            case .clearDay:         return "\u{f00d}"
            case .clearNight:       return "\u{f02e}"
            case .rain:             return "\u{f019}"
            case .snow:             return "\u{f01b}"
            case .sleet:            return "\u{f0b5}"
            case .wind:             return "\u{f050}"
            case .fog:              return "\u{f014}"
            case .cloudy:           return "\u{f013}"
            case .partyCloudyDay:   return "\u{f002}"
            case .partyCloudyNight: return "\u{f086}"
            case .hail:             return "\u{f015}"
            case .thunderstorm:     return "\u{f01e}"
            case .tornado:          return "\u{f056}"
            }
        }
    }
}
