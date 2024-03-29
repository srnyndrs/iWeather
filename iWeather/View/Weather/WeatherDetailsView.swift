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
                    WeatherInfoView(cityName: weatherViewModel.cityName, temperature: weatherViewModel.temperature, weatherIconId: weatherViewModel.weatherIconImage, weatherDescription: weatherViewModel.weatherDescription)
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
                    Spacer()
                }.frame(minHeight: geometry.size.height)
            }
            .padding(.top, 1)
            .padding(.bottom, 6).frame(width: geometry.size.width)
            .onAppear {
                weatherViewModel.fetchData()
                forecastViewModel.fetchData()
            }
        }.refreshable {
            weatherViewModel.locationManager?.getLocation()
            forecastViewModel.locationManager?.getLocation()
            weatherViewModel.fetchData(true)
            forecastViewModel.fetchData(true)
        }
    }
}
