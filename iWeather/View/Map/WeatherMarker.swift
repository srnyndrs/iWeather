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
                .fill(.cyan)
                .stroke(.secondary, lineWidth: 1)
                .foregroundColor(.black)
            VStack(alignment: .center, spacing: 0) {
                Text(weatherViewModel.weatherIcon)
                    .font(.title)
                Text(" \(weatherViewModel.temperature)°C")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
        }
        .task {
            await weatherViewModel.refresh()
        }
    }
}


#Preview {
    WeatherMarker(weatherViewModel: WeatherViewModel(weatherService: WeatherService(), location: Constants.MockUserLocation.coordinate))
}
