//
//  WeatherListItem.swift
//  iWeather
//
//  Created by Suranyi on 09/11/2023.
//

import SwiftUI

struct LocationItemView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    var locationName: String?
    var body: some View {
        HStack {
            LocationRowView(cityName: locationName ?? weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIconId: weatherViewModel.weatherIconImage, weatherDescription: weatherViewModel.weatherDescription)
                .foregroundColor(.white)
        }.task {
            //await weatherViewModel.refresh()
            weatherViewModel.fetchData()
        }
    }
}
