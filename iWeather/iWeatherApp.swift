//
//  iWeatherApp.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI

@main
struct iWeatherApp: App {
    private var weatherService = WeatherService()
    private var geocodingService = GeocodingService()
    @StateObject private var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                // ViewModel initializations
                let weatherViewModel = WeatherViewModel(weatherService: weatherService, location: locationManager.locationCoordinate, locationManager: locationManager)
                let forecastViewModel = ForecastViewModel(weatherService: weatherService, location: locationManager.locationCoordinate, locationManager: locationManager)
                let locationViewModel = LocationViewModel(weatherService: weatherService)
                let geocodingViewModel = GeocodingViewModel(geocodingService: geocodingService)
                // MainView initialization
                MainView(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel, locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel, locationManager: locationManager, weatherService: weatherService)
            } else {
                // Error message
                VStack {
                    ProgressView()
                    Text("The location is not granted!")
                        .font(.title)
                }
            }
        }
    }
}

