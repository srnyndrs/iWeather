//
//  WeatherView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI

struct WeatherScene: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            WeatherInfoView(weatherViewModel: weatherViewModel)
            Spacer()
            ForecastInfoView(forecastViewModel: forecastViewModel)
            Spacer()
        }
    }
    
}
