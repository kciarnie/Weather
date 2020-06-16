//
//  DarkSkyViewModel.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
import UIKit

typealias WeatherServiceSuccess = () -> Void
typealias WeatherServiceFailure = (Error) -> Void

/**
 The DarkSkyViewModel follows the MVVM pattern which can take in a DarkSkyService and is used to convert between objects and the
 `WeatherDetailsViewController.swift` class
 */
class DarkSkyViewModel {
    private lazy var weatherService = DarkSkyWeatherService(apiKey: DARKSKY_API_KEY)

    private var model: DarkSky?
    private var city: City

    var location: String?
    var summary: String?
    var icon: String?
    var temperature: String?
    var highTemperature: String?
    var lowTemperature: String?
    var feelsLike: String?
    var sunrise: String?
    var sunset: String?
    var humidity: String?
    var pressure: String?
    var cloudiness: String?
    var windSpeed: String?
    
    var daily: [DailyDataPoint]?
    var today: DailyDataPoint?
    var tomorrow: DailyDataPoint?
    var timezone: TimeZone?
    
    init(city: City) {
        self.city = city
    }
    
    /**
     Used to display the unit of measure for degrees
     */
    private func getTemperatureUnit() -> String {
        switch self.city.units {
            case Units.us:
                return "°F"
            default:
                return "°C"
        }
    }
    
    /**
     Updates the values which will be used to display to the `HeaderTableViewCell`
     
     - Parameter model: The main entry point model of the DarkSkyService
     */
    private func update(model: DarkSky) {
        timezone = TimeZone(identifier: model.timezone)
        
        self.daily = model.daily?.list
        self.today = daily?.first
        self.tomorrow = daily?[1]

        
        self.location = city.name.uppercased()
        self.summary = model.currently.summary?.uppercased() ?? ""
        self.icon = model.currently.icon.iconString
        self.temperature = model.currently.temperature?.showAsTemperature(city)
        self.highTemperature = today?.temperatureHigh?.showAsTemperature(city)
        self.lowTemperature = today?.temperatureLow?.showAsTemperature(city)
        self.feelsLike = model.currently.apparentTemperature?.showAsTemperature(city)

        self.sunrise = WeatherDateTime(date: today?.sunriseTime ?? 0, timeZone: timezone).getShortTime()
        self.sunset = WeatherDateTime(date: today?.sunsetTime ?? 0, timeZone: timezone).getShortTime()
        self.humidity = model.currently.getHumidity()
        self.pressure = model.currently.getPressure()
        self.cloudiness = model.currently.cloudCover?.showPercentage()
        self.windSpeed = showAsWind(city, model.currently.windSpeed, model.currently.windBearing)
    }
    
    /**
     Displays the wind as a viewable string
     
     - Parameter city: the current city which has the units function
     - Parameter windSpeed: the current wind speed
     - Parameter windDirection: The current wind direction which will be converted to a compass direction
     
     - Returns: a string representation of the wind as XX <Direction> <km/hr>
     */
    func showAsWind(_ city: City, _ windSpeed: Double?, _ windDirection: Double?) -> String {
        return "\(windSpeed ?? 0) \(windDirection?.windDegreesToDirection() ?? "") \(showSpeedUnits(city.units))"
    }
    
    /**
     Shows the proper string relative to the units
     
     - Parameter units: The units of measure
     */
    func showSpeedUnits(_ units: Units) -> String {
        switch units {
            case Units.us:
                return "mi/hr"
            default:
                return "km/hr"
        }
    }
    
    /**
     Features the weather for the current city
     
     - Parameter success: called if the current weatherService is successful and updates the screen
     - Parameter failure: Called which the service is not successful
     */
    func fetchWeather(success: @escaping WeatherServiceSuccess, failure: @escaping WeatherServiceFailure) {
        weatherService.getCurrentWeather(city: city, success: { (model) in
            self.update(model: model)
            success()
        }, failure: { (error) in
            failure(error)
        })

    }
    
    /**
     Cancels the webservice
     */
    func cancel() {
        self.weatherService.cancel()
    }
}

extension Int {
    
    /**
     A display function for displaying the units of temperature
     
     - Parameter units: The units for the current city
     */
    func showTemperatureUnits(_ units: Units) -> String {
        switch units {
            case Units.us:
                return "\(self)°F"
            default:
                return "\(self)°C"
        }
    }
}

extension Double {
    /**
     Converts the decimal to a percentage
     
     - Returns: Whole number representation fo a percentage
     */
    func percent() -> Double {
        return self * 100
    }
    
    /**
     Converts a double to an int
     
     - Returns: Int class based number
     */
    func int() -> Int {
        return Int(self)
    }
    
    /**
     Rounds up the double to an integer
     
     - Returns: rounded up value of a double as an int
     */
    func roundUp() -> Int {
        return Int(Darwin.round(self))
    }
    
    /**
     Display function of a double to a temperature string
     
     - Parameter city: the current city
     
     - Returns: double as a temperature string
     */
    func showAsTemperature(_ city: City) -> String {
        return self.roundUp().showTemperatureUnits(city.units)
    }
    
    /**
     Shows the double as a percentage by converting the fraction to a whole number and adding a % sign
     
     - Returns: a percentage in string form (ie. 98 %)
     */
    func showPercentage() -> String {
        return "\(self.percent().int()) %"
    }
}
