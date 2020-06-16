//
//  WeatherList.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 An extension in order to show the data as a `list` class
 */
extension DarkSky {
    
    struct List<T: Codable & Identifiable>: Codable {
        
        var list: [T]
        
        enum CodingKeys: String, CodingKey {
            case list = "data"
        }
    }
}
