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

    var body: some Scene {
        WindowGroup {
            let weatherViewModel = WeatherViewModel(weatherService: weatherService)
            let forecastViewModel = ForecastViewModel(weatherService: weatherService)
            MainView(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
