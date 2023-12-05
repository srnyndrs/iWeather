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
    let weatherService: WeatherService
    var locationManager: LocationManager?
    
    @Published var cityName: String = "City Name"
    @Published var forecast: [Forecast] = []
    @Published var timezone: Int = 0
    
    private var loaded: Bool = false
    
    init(weatherService: WeatherService, location: CLLocationCoordinate2D, locationManager: LocationManager? = nil) {
        self.weatherService = weatherService
        self.location = location
        self.locationManager = locationManager
        self.locationManager?.locationObservers.append(self)
    }
    
    func fetchData(_ forced: Bool = false) {
        if !loaded || forced {
            weatherService.fetchForecastData(coords: location) { forecast in
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

extension ForecastViewModel : LocationObserver {
    func updateLocation(_ location: CLLocationCoordinate2D) {
        self.location = location
        self.fetchData(true)
    }
}
