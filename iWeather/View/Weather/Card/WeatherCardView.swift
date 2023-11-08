//
//  WeatherCardView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct WeatherCardView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Text(weatherViewModel.cityName)
                .font(.system(size: 20))
            Spacer()
            Text(weatherViewModel.temperature + " C°")
                .font(.system(size: 20))
                .bold()
            Spacer()
            Text(weatherViewModel.weatherIcon)
                .font(.system(size: 20))
            Spacer()
            Text(weatherViewModel.weatherDescription)
                .font(.system(size: 20))
            Spacer()
        }
    }
}
