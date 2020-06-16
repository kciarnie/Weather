//
//  TestData.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

/**
 A test class used to hard-code cities
 */
class TestData {
    
    
    // This is a function that creates Test data cities for inputting into the `ViewController.swift`
    public static func getCities() -> [City] {
        // https://www.latlong.net/place/vancouver-bc-canada-2279.html
        let vancouver = City("Vancouver", "British Columbia, Canada", 49.246292, -123.116226, Units.ca)

        // https://www.latlong.net/place/vienna-austria-4542.html
        let vienna = City("Vienna", "Austria", 48.210033, 16.363449, Units.si)

        // https://www.latlong.net/place/salzburg-austria-12985.html
        let salzburg = City("Salzburg", "Austria", 47.811195, 13.033229, Units.si)

        // https://www.latlong.net/place/vancouver-bc-canada-2279.html
        let lasVegas = City("Las Vegas", "Nevada, USA", 36.114647, -115.172813, Units.us)

        // https://www.latlong.net/place/atlanta-ga-usa-6566.html
        let atlanta = City("Atlanta", "Georgia, USA", 33.753746, -84.386330, Units.us)
        
        return [vienna, salzburg, vancouver, lasVegas, atlanta]
        
    }
}
