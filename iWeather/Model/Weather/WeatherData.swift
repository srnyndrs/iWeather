//
//  Weather.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

public struct WeatherData {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    let weatherIconUrl: String
    let wind: String
    
    init(response: WeatherResponse?) {
        city = response?.name ?? ""
        temperature = "\(Int(response?.main.temp ?? 0))"
        description = response?.weather.first?.description ?? ""
        iconName = response?.weather.first?.main ?? ""
        weatherIconUrl = ("https://openweathermap.org/img/wn/\(response?.weather.first?.icon ?? "")@2x.png") 
        wind = "\(Int(response?.wind.speed ?? 0))"
    }
    
}
