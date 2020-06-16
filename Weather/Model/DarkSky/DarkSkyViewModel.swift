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
    
    init(city: City) {
        self.city = city
    }
    
    private func getTemperatureUnit() -> String {
        switch self.city.units {
            case Units.us:
                return "°F"
            default:
                return "°C"
        }
    }
    
    private func update(model: DarkSky) {
        let timezone = TimeZone(identifier: model.timezone)
        
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

        self.sunrise = WeatherDateTime(date: today?.sunriseTime ?? 0, timeZone: timezone).shortTime
        self.sunset = WeatherDateTime(date: today?.sunsetTime ?? 0, timeZone: timezone).shortTime
        self.humidity = model.currently.getHumidity()
        self.pressure = model.currently.getPressure()
        self.cloudiness = model.currently.cloudCover?.showPercentage()
        self.windSpeed = showAsWind(city, model.currently.windSpeed, model.currently.windBearing)
    }
    
    func showAsWind(_ city: City, _ windSpeed: Double?, _ windDirection: Double?) -> String {
        return "\(windSpeed ?? 0) \(windDirection?.windDegreesToDirection() ?? "") \(showSpeedUnits(city.units))"
    }
    
    func showSpeedUnits(_ units: Units) -> String {
        switch units {
            case Units.us:
                return "mi/hr"
            default:
                return "km/hr"
        }
    }
    
    func fetchWeather(success: @escaping WeatherServiceSuccess, failure: @escaping WeatherServiceFailure) {
        weatherService.getCurrentWeather(city: city, success: { (model) in
            self.update(model: model)
            success()
        }, failure: { (error) in
            failure(error)
        })

    }
    
    func cancel() {
        self.weatherService.cancel()
    }
}

extension Int {
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
    func percent() -> Double {
        return self * 100
    }
    
    func int() -> Int {
        return Int(self)
    }
    
    func roundUp() -> Int {
        return Int(Darwin.round(self))
    }
    
    func showAsTemperature(_ city: City) -> String {
        return self.roundUp().showTemperatureUnits(city.units)
    }
    
    func showPercentage() -> String {
        return "\(self.percent().int()) %"
    }
}
