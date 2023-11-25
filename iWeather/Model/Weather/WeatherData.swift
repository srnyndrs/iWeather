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
    let humidity: String
    let sunriseRaw: Int
    let sunsetRaw: Int
    
    var sunrise: String {
        return formateDate(sunriseRaw)
    }
    
    var sunset: String {
        return formateDate(sunsetRaw)
    }
    
    init(response: WeatherResponse?) {
        city = response?.name ?? ""
        temperature = "\(Int(response?.main?.temp ?? 0))"
        description = response?.weather?.first?.description ?? ""
        iconName = response?.weather?.first?.icon ?? ""
        weatherIconUrl = ("https://openweathermap.org/img/wn/\(response?.weather?.first?.icon ?? "")@2x.png")
        wind = "\(Int(response?.wind?.speed ?? 0))"
        humidity = "\(Int(response?.main?.humidity ?? 0))"
        sunriseRaw = (Int(response?.sys?.sunrise ?? 0) + Int(response?.timezone ?? 0))
        sunsetRaw = (Int(response?.sys?.sunset ?? 0) + Int(response?.timezone ?? 0))
    }
    
    func formateDate(_ millis: Int) -> String {
        if millis == 0 {
            return "Unknown"
        } else {
            let timeFormat = DateFormatter()
            timeFormat.dateFormat = "HH:mm"
            
            return timeFormat.string(from: Date(timeIntervalSince1970: Double(millis)))
        }
    }
    
}
