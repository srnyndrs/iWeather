//
//  WeatherDetailsView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            WeatherInfoView(cityName: weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIcon: weatherViewModel.weatherIcon, weatherDescription: weatherViewModel.weatherDescription)
            Spacer()
            ForecastInfoView(forecast: forecastViewModel.forecast)
            Spacer()
        }.task {
            print("Refresh details view")
            await weatherViewModel.refresh()
            await forecastViewModel.refresh()
        }
    }
}
