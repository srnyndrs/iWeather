//
//  LocationItem.swift
//  iWeather
//
//  Created by Suranyi on 09/11/2023.
//

import Foundation
import MapKit
import SwiftUI

class LocationItem: ObservableObject {
    @Published var weatherViewModel: WeatherViewModel
    @Published var forecastViewModel: ForecastViewModel
    
    init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherViewModel = WeatherViewModel(weatherService: weatherService, location: location)
        self.forecastViewModel = ForecastViewModel(weatherService: weatherService, location: location)
    }
}
