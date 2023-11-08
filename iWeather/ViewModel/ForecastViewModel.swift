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
    @Published var cityName: String = "City Name"
    @Published var forecast: [Forecast] = []
    
    public var weatherService: WeatherService? = nil
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() async {
        await weatherService!.loadForecastData() { forecast in
             DispatchQueue.main.async {
                 self.cityName = forecast.city
                 self.forecast = forecast.forecastList
            }
        }
    }
}
