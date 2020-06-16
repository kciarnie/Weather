//
//  Units.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
Units in which the [Dark Sky API](https://darksky.net/dev/docs) data returns in
 */
public enum Units: String, Decodable {
    
    /// Standard units
    case si = "si"
    
    /// US units and the default option.
    case us = "us"
    
    /// Canadian units. Identical to `.si` except `windSpeed` is in kilometers per hour. (Defaulted to the one we use)
    case ca = "ca"
    
    /// UK units. Identical to `.si` except `windSpeed` is in miles per hour, and `nearestStormDistance` and `visibility` are in miles.
    case uk = "uk2"
    
    /// Automatically use the appropriate units based on the location for which you are requesting data.
    case auto = "auto"    
}
