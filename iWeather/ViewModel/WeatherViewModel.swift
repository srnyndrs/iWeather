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
    @Published var weatherIcon: String = Constants.defaultIcon
    private var loaded: Bool
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
        self.loaded = false
    }
    
    public func refresh() async {
        if !loaded {
            await weatherService.populateWeatherData(coords: location) { weather in
                DispatchQueue.main.async {
                    self.cityName = weather.city
                    self.temperature = "\(weather.temperature)"
                    self.weatherDescription = weather.description.capitalized
                    self.weatherIcon = Constants.iconMap[weather.iconName] ?? Constants.defaultIcon
                    self.loaded = true
                }
            }
        }
    }
}

