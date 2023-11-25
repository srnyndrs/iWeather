//
//  ForecastViewModel.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation

class ForecastViewModel: ObservableObject {
    var location: CLLocationCoordinate2D
    @Published var cityName: String = "City Name"
    @Published var forecast: [Forecast] = []
    @Published var timezone: Int = 0
    private var loaded: Bool
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
        self.loaded = false
    }
    
    public func refresh() async {
        if !loaded {
            await weatherService.populateForecastData(coords: location) { forecast in
                DispatchQueue.main.async {
                    self.cityName = forecast.cityName
                    self.forecast = forecast.forecastList
                    self.timezone = forecast.timezone
                    self.loaded = true
                }
            }
        }
    }

}
