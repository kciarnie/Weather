//
//  DarkSkyViewModel.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
import UIKit

class DarkSkyViewModel {
    
    private var model: DarkSky
    private var city: City
    
    var temperature: String?
    var location: String?
    var icon: String?
    var summary: String?
    
    func currentSummary() -> String {
        return model.current.summary?.uppercased() ?? ""
    }
    
    func currentLocation() -> String {
        return city.name.uppercased()
    }

    func currentTemperature() -> String {
        return "\(roundUp(model.current.temperature))\(getTemperatureUnit())"
    }
    
    func currentIcon() -> UIImage {
        return model.current.icon.icon
    }
    
    func currentIconString() -> String {
        return model.current.icon.iconString
    }
    
    private func getTemperatureUnit() -> String {
        switch self.city.units {
            case Units.us:
                return "°F"
            default:
                return "°C"
        }
    }
    
    private func roundUp(_ value: Double) -> Int  {
        return Int(Darwin.round(value))
    }
    
    init(model: DarkSky, city: City ) {
        self.model = model
        self.city = city
        
        self.temperature = self.currentTemperature()
        self.location = currentLocation()
        self.summary = currentSummary()
        self.icon = currentIconString()
    }
}
