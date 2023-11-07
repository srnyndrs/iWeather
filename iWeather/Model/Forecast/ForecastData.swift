//
//  ForecastData.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

public struct ForecastData {
    let city: String
    let forecastList: [Forecast]
    //let temperature: String
    //let description: String
    //let iconName: String
    
    init(response: ForecastResponse?) {
        city = response?.city.name ?? ""
        forecastList = response?.list ?? []
        //temperature = "\(Int(response?.main.temp ?? 0))"
        //description = response?.weather.first?.description ?? ""
        //iconName = response?.weather.first?.main ?? ""
    }
    
}
