//
//  WeatherIcon.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
import UIKit

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

        var icon: UIImage {
            switch self {
            case .clearDay:
                return UIImage(named: "clear-day")!
            case .clearNight:
                return UIImage(named: "clear-night")!
            case .rain:
                return UIImage(named: "rain")!
            case .snow:
                return UIImage(named: "snow")!
            case .sleet:
                return UIImage(named: "sleet")!
            case .wind:
                return UIImage(named: "wind")!
            case .fog:
                return UIImage(named: "fog")!
            case .cloudy:
                return UIImage(named: "cloudy")!
            case .partyCloudyDay:
                return UIImage(named: "cloudy-day")!
            case .partyCloudyNight:
                return UIImage(named: "cloudy-night")!
            default:
                return UIImage(named: "default")!

            }
        }
        
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
            default:                return "\u{f055}"
            }
        }
    }
}
