//
//  City.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

class City {
    let name: String
    let country: String
    let latitude: Double
    let longitdude: Double
    let units: Units

    init(_ name: String, _ country: String, _ latitude: Double, _ longitdude: Double, _ units: Units) {
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitdude = longitdude
        self.units = units
    }
}
