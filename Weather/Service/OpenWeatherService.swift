//
//  WeatherService.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

//Protocol describes features of something without telling what it is
protocol OpenWeatherServiceDelegate {
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(message: String)
}

typealias CurrentOpenWeatherServiceSuccess = (OpenWeather) -> Void
typealias ForecastOpenWeatherServiceSuccess = (OpenWeather) -> Void
typealias OpenWeatherServiceFailure = (Error) -> Void


class OpenWeatherService {
    
    var delegate: OpenWeatherServiceDelegate?
    var apiKey: String = ""
    var urlSessionTask: URLSessionDataTask?

    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func getURL(city: String, type: String) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/\(type)"
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: self.apiKey)
        ]

        // Getting a URL from our components is as simple as
        // accessing the 'url' property.
        return components.url
    }
    
    func getCurrentWeather(city: String, success: @escaping CurrentOpenWeatherServiceSuccess, failure: @escaping OpenWeatherServiceFailure) {
        //session for exchanging data
        guard let url = self.getURL(city: city, type: "weather") else {
            print("There was an error obtaining the URL. Please try again")
            return
        }
        
        urlSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    failure(error!)
                    return
                }
                
                if error != nil {
                    failure(error!)
                    return
                }
                
                let forecast = try JSONDecoder().decode(OpenWeather.self, from: data)                
                success(forecast)
            } catch {
                debugPrint(error)
                failure(error)
            }
        }
        urlSessionTask?.resume()
    }
    
    func getForecastWeather(city: String, success: @escaping ForecastOpenWeatherServiceSuccess, failure: @escaping OpenWeatherServiceFailure) {
        //session for exchanging data
        guard let url = self.getURL(city: city, type: "forecast") else {
            print("There was an error obtaining the URL. Please try again")
            return
        }
        
        urlSessionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    failure(error!)
                    return
                }
                
                if error != nil {
                    failure(error!)
                    return
                }
                
                let forecast = try JSONDecoder().decode(OpenWeather.self, from: data)
                success(forecast)
            } catch {
                debugPrint(error)
                failure(error)
            }
        }
        urlSessionTask?.resume()
    }
    
    func cancel() {
        urlSessionTask?.cancel()
    }
}
