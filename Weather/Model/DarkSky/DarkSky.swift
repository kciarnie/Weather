//
//  DarkSky.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 The main entry point for the DarkSkyService
 */
struct DarkSky: Codable {
    var timezone: String
    var currently: DailyDataPoint
    var daily: DarkSky.List<DailyDataPoint>?
}
