//
//  WeatherViewModel.swift
//  iWeather
//
//  Created by Suranyi on 06/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    var location: CLLocationCoordinate2D
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
    }
    
    public func refresh() async {
        await weatherService.populateWeatherData(coords: location) { weather in
             DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}

private let defaultIcon = "❓"

private let iconMap = [
    "Drizzle" : "🌧️",
    "Thunderstorm" : "⛈️",
    "Rain" : "🌧️",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "☁️",
]
