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
    private var loaded: Bool
    
    public var weatherService: WeatherService? = nil
    
    public init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
        self.loaded = false
    }
    
    public func refresh() async {
        if !loaded {
            await weatherService!.populateForecastData(coords: location) { forecast in
                DispatchQueue.main.async {
                    self.cityName = forecast.city
                    self.forecast = forecast.forecastList
                    self.loaded = true
                }
            }
        }
    }
}
