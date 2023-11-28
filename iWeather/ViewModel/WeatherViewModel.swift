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
    let weatherService: WeatherService
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var weatherDescription: String = ""
    @Published var weatherIcon: String = ""
    @Published var weatherIconImage: String = ""
    @Published var wind: String = ""
    @Published var humidity: String = ""
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    private var loaded: Bool = false
    
    init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
    }
    
    func refresh() async {
        if !loaded {
            await weatherService.populateWeatherData(coords: location) { weather in
                DispatchQueue.main.async {
                    self.cityName = weather.city
                    self.temperature = "\(weather.temperature)"
                    self.weatherDescription = weather.description.capitalized
                    self.weatherIcon = Constants.iconMap[weather.iconName] ?? Constants.defaultIcon
                    self.weatherIconImage = weather.weatherIconUrl
                    self.wind = weather.wind
                    self.humidity = weather.humidity
                    self.sunrise = weather.sunrise
                    self.sunset = weather.sunset
                    self.loaded = true
                }
            }
        }
    }
}

