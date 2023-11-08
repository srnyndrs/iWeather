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
    
    func populateWeatherData(coords: CLLocationCoordinate2D, _ completionHandler: @escaping((WeatherData) -> Void)) async {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        do {
            let response = try await NetworkManager().get(url: URL(string: urlString)!) { data in
                return try? JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            completionHandler(WeatherData(response: response))
        } catch {
            print(error)
        }
    }
    
    func populateForecastData(coords: CLLocationCoordinate2D, _ completionHandler: @escaping((ForecastData) -> Void)) async {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        do {
            let response = try await NetworkManager().get(url: URL(string: urlString)!) { data in
                return try? JSONDecoder().decode(ForecastResponse.self, from: data)
            }
            completionHandler(ForecastData(response: response))
        } catch {
            print(error)
        }
    }
}
