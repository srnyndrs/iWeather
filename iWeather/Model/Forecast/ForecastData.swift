//
//  ForecastData.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

public struct ForecastData {
    let cityName: String
    let timezone: Int
    let forecastList: [Forecast]
    
    init(response: ForecastResponse?) {
        cityName = response?.city?.name ?? ""
        timezone = response?.city?.timezone ?? 0
        forecastList = response?.list ?? []
    }
    
}
