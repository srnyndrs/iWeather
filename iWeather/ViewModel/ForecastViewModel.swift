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
    
    public var weatherService: WeatherService? = nil
    
    public init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherService = weatherService
        self.location = location
    }
    
    public func refresh() async {
        await weatherService!.populateForecastData(coords: location) { forecast in
             DispatchQueue.main.async {
                 self.cityName = forecast.city
                 self.forecast = forecast.forecastList
            }
        }
    }
}
