//
//  Daily.swift
//  Weather
//
//  Created by Kevin on 2020-06-15.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 The daily entry point of the data coming from the DarkSkyService
 */
struct Daily: Codable {
    
    var summary: String
    var icon: DarkSky.Icon
    var data : [DailyDataPoint]
}
