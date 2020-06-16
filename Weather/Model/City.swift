//
//  City.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 The City listing class string. It contains the city, country, latitude, longitude and SI Units for the specific city.
 */
class City {
    let name: String
    let country: String
    let latitude: Double
    let longitdude: Double
    let units: Units

    /**
     Constructor
     
     - Parameter name: The name of the city
     - Parameter country: The state/province and country
     - Parameter latitude: the latitidue
     - Parameter longitude: the longitude
     - Parameter units: the SI units
     */
    init(_ name: String, _ country: String, _ latitude: Double, _ longitdude: Double, _ units: Units) {
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitdude = longitdude
        self.units = units
    }
}
