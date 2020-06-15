//
//  Daily.swift
//  Weather
//
//  Created by Kevin on 2020-06-15.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct Daily: Codable {
    
    var summary: String
    var icon: DarkSky.Icon
    var data : [DailyDataPoint]
}
