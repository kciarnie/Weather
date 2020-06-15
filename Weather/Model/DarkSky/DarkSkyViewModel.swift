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
    
    var daily: DarkSky.List<DailyWeather>?
    var today: DailyDataPoint?
    var tomorrow: DailyDataPoint?
    var currently: DailyWeather?
    
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
        self.location = city.name.uppercased()
        self.summary = model.currently.summary?.uppercased() ?? ""
        self.icon = model.currently.icon.iconString
        self.temperature = model.currently.temperature.showAsTemperature(city)
        self.highTemperature = "TODO"
        self.lowTemperature = "TODO"
        self.feelsLike = model.currently.apparentTemperature?.showAsTemperature(city)
        self.sunrise = "TODO"
        self.sunset = "TODO"
        self.humidity = model.currently.getHumidity()
        self.pressure = model.currently.getPressure()
        self.cloudiness = model.currently.cloudCover?.showPercentage()
        self.windSpeed = showAsWind(city, model.currently.windSpeed, model.currently.windBearing)
        
        self.daily = model.daily
    }
    
    func showAsWind(_ city: City, _ windSpeed: Double?, _ windDirection: Double?) -> String {
        return "\(windSpeed ?? 0) \(windDirection?.showAsSpeed(city) ?? "")"
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
    
    func showSpeedUnits(_ units: Units) -> String {
        switch units {
            case Units.us:
                return "\(self) mi/hr"
            default:
                return "\(self) km/hr"
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
    
    func showAsSpeed(_ city:City) -> String {
        return self.roundUp().showSpeedUnits(city.units)
    }
    
    func showPercentage() -> String {
        return "\(self.percent().int()) %"
    }
}
