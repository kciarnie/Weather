//
//  DarkSkyWeatherService.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

//Protocol describes features of something without telling what it is
protocol DarkSkyServiceDelegate {
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(message: String)
}

typealias DarkSkyServiceSuccess = (DarkSky) -> Void
typealias DarkSkyServiceFailure = (Error) -> Void


class DarkSkyWeatherService {
    
    var delegate: DarkSkyServiceDelegate?
    var apiKey: String = ""
    var urlSessionTask: URLSessionDataTask?
    
    open var units: Units?
    open var language: Language?
    
    static let URL = "https://api.darksky.net/forecast"

    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func buildURL(city: City, excludeFields: [String]) -> URL? {

        // Build URL path
        let urlString = "\(DarkSkyWeatherService.URL)/\(apiKey)/\(city.latitude),\(city.longitdude)"

        // Build URL query parameters
        var urlBuilder = URLComponents(string: urlString)!
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "units", value: city.units.rawValue))
        if let language = self.language {
            queryItems.append(URLQueryItem(name: "lang", value: language.rawValue))
        }

        if !excludeFields.isEmpty {
            var excludeFieldsString = ""
            for field in excludeFields {
                if excludeFieldsString != "" {
                    excludeFieldsString.append(",")
                }
                excludeFieldsString.append("\(field)")
            }
            queryItems.append(URLQueryItem(name: "exclude", value: excludeFieldsString))
        }
        urlBuilder.queryItems = queryItems
    
        return urlBuilder.url
    }
    
    func getCurrentWeather(city: City, success: @escaping DarkSkyServiceSuccess, failure: @escaping DarkSkyServiceFailure) {
        //session for exchanging data
        guard let url = self.buildURL(city: city, excludeFields: ["flags", "minutely", "hourly"]) else {
            print("There was an error obtaining the URL. Please try again")
            return
        }
        
        print("url: \(url)")
        
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
                
                let forecast = try JSONDecoder().decode(DarkSky.self, from: data)
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
