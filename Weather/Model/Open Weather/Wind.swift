//
//  Wind.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

extension Wind {
    func windDirectionFromDegree(deg: Double) -> String {
        // Based on http://www.climate.umn.edu/snow_fence/components/winddirectionanddegreeswithouttable3.htm
        
        if (deg > 326.25) || (deg <= 56.25) { // NNW, N, NNE, NE
            return "↑"
        } else if (deg > 56.25) && (deg <= 146.25) { // ENE, E, ESE, SE
            return "→"
        } else if (deg > 146.25) && (deg <= 236.25) { // SSE, S, SSW, SW
            return "↓"
        } else if (deg > 236.25) && (deg <= 326.25) { // WSW, W, WNW, NW
            return "←"
        } else {
            return "x"
        }
    }
}
