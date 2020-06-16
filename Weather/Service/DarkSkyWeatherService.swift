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

/// Alias used to show the @escaping values of a successful DarkSky Call
typealias DarkSkyServiceSuccess = (DarkSky) -> Void
/// Alias used to show the @escaping values of a failed DarkSky Call
typealias DarkSkyServiceFailure = (Error) -> Void


/**
 A network wrapper using URLSession for Dark Sky API
 */
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
    
    /**
     Builds the URL
     
     - Parameter city: the city variable
     - Parameter excludeFields: a String representation of all the data that isn't needed from the Endpoint. ie. hourly is used to remove the hourly forecast
     
    - Returns: a URL object
     */
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
    
    /**
     the getCurrentWeather call will access the DarkSky API and return data as a DarkSky.swift object class
     
     - Parameter city: The city
     - Parameter success: the success alias used to parse a proper success and send it to the ViewModel layer
     - Parameter failure: the failure alias used to parse a failure  and send it to the ViewModel layer

     */
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
    
    /**
     Cancels the Network connection
     */
    func cancel() {
        urlSessionTask?.cancel()
    }
}
