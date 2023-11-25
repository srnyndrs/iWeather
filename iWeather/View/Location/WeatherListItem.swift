//
//  WeatherListItem.swift
//  iWeather
//
//  Created by Suranyi on 09/11/2023.
//

import SwiftUI

struct WeatherListItem: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    var body: some View {
        HStack {
            WeatherCardView(cityName: weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIcon: weatherViewModel.weatherIcon, weatherIconId: weatherViewModel.weatherIconImage, weatherDescription: weatherViewModel.weatherDescription)
        }.task {
            print("Refresh list item view")
            await weatherViewModel.refresh()
        }
    }
}
