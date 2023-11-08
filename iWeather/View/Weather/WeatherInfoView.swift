//
//  WeatherInfoView.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import SwiftUI

struct WeatherInfoView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(weatherViewModel.cityName)
                .font(.largeTitle)
            Text(weatherViewModel.temperature + " C°")
                .font(.system(size: 70))
                .bold()
            Text(weatherViewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            Text(weatherViewModel.weatherDescription)
        }.padding()
    }
}
