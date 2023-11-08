//
//  LocationDetailView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack {
            WeatherInfoView(cityName: weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIcon: weatherViewModel.weatherIcon, weatherDescription: weatherViewModel.weatherDescription)
        }
    }
}
