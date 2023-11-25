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
        WeatherDetailsView(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel).padding(.top, 64)
    }
    
}
