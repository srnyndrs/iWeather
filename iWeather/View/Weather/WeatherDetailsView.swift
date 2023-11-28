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
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    Spacer()
                    WeatherInfoView(cityName: weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIcon: weatherViewModel.weatherIcon, weatherIconId: weatherViewModel.weatherIconImage, weatherDescription: weatherViewModel.weatherDescription)
                    Spacer()
                    Text("Forecast")
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForecastInfoView(forecast: forecastViewModel.forecast, timezone: forecastViewModel.timezone)
                    Spacer()
                    Text("Additional")
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    AdditionalInfoView(wind: weatherViewModel.wind, humidity: weatherViewModel.humidity, sunrise: weatherViewModel.sunrise, sunset: weatherViewModel.sunset)
                }.frame(minHeight: geometry.size.height)
            }
            .padding(.top, 1)
            .padding(.bottom, 6).frame(width: geometry.size.width)
            .task {
                await weatherViewModel.refresh()
                await forecastViewModel.refresh()
            }
        }
    }
}
