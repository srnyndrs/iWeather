//
//  WeatherMarker.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import SwiftUI

struct WeatherMarker: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.background)
            RoundedRectangle(cornerRadius: 5)
                .stroke(.secondary, lineWidth: 5)
            Text(weatherViewModel.weatherIcon)
                .padding(8)
        }.task {
            await weatherViewModel.refresh()
        }
    }
}
