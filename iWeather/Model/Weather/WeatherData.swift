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
    
    init(response: WeatherResponse?) {
        city = response?.name ?? ""
        temperature = "\(Int(response?.main.temp ?? 0))"
        description = response?.weather.first?.description ?? ""
        iconName = response?.weather.first?.main ?? ""
    }
    
}
