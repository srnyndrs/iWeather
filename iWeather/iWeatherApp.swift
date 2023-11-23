//
//  iWeatherApp.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI

@main
struct iWeatherApp: App {
    let persistenceController = PersistenceController.shared
    private var weatherService = WeatherService()
    private var geocodingService = GeocodingService()
    private var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                let weatherViewModel = WeatherViewModel(weatherService: weatherService, location: locationManager.locationCoordinate)
                let forecastViewModel = ForecastViewModel(weatherService: weatherService, location: locationManager.locationCoordinate)
                let locationViewModel = LocationViewModel(weatherService: weatherService)
                let geocodingViewModel = GeocodingViewModel(geocodingService: geocodingService)
                
                //let context = persistenceController.container.viewContext
                //let locationHolder = LocationHolder(context)
                
                MainView(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel, locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel, locationManager: locationManager, weatherService: weatherService)
                    //.environment(\.managedObjectContext, persistenceController.container.viewContext)
                    //.environmentObject(locationHolder)
            } else {
                Text("The location is not granted!")
            }
        }
    }
}

