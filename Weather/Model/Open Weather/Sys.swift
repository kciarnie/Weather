//
//  Sys.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Double?
    let country: String
    let sunrise: Int
    let sunset: Int
}
