//
//  LocationItem.swift
//  iWeather
//
//  Created by Suranyi on 09/11/2023.
//

import Foundation
import MapKit

class LocationItem {
    var weatherViewModel: WeatherViewModel
    var forecastViewModel: ForecastViewModel
    
    init(weatherService: WeatherService, location: CLLocationCoordinate2D) {
        self.weatherViewModel = WeatherViewModel(weatherService: weatherService, location: location)
        self.forecastViewModel = ForecastViewModel(weatherService: weatherService, location: location)
    }
}
