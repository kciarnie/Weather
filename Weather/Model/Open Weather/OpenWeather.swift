//
//  CurrentWeather.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
struct OpenWeather: Codable {
    
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var rain: Rain?
    var snow: Snow?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
    var id: Int?
    var name: String?
    var statuscode: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case coord      = "coord"
        case weather    = "weather"
        case base       = "base"
        case main       = "main"
        case visibility = "visibility"
        case wind       = "wind"
        case rain       = "rain"
        case snow       = "snow"
        case clouds     = "clouds"
        case dt         = "dt"
        case sys        = "sys"
        case timezone   = "timezone"
        case name       = "name"
        case statuscode = "cod"
    }
}
