//
//  WeatherService.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject, ObservableObject {
    private let API_KEY: String = "e74998255d559f5a0ac8fe4a4436a9a3"
    
    func fetchWeatherData(coords: CLLocationCoordinate2D, _ completionHandler: @escaping((WeatherData) -> Void)) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
                        do {
                            let response = try decoder.decode(WeatherResponse.self, from: data)
                            completionHandler(WeatherData(response: response))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchForecastData(coords: CLLocationCoordinate2D, _ completionHandler: @escaping((ForecastData) -> Void)) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
                        do {
                            let response = try decoder.decode(ForecastResponse.self, from: data)
                            completionHandler(ForecastData(response: response))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
