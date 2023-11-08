//
//  ForecastCardView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct ForecastCardView: View {
    var forecast: Forecast
    
    var body: some View {
        VStack(alignment: .center) {
            Text(formatDate(originalDateString: forecast.dtTxt).first ?? "")
                .font(.title3)
            Text(formatDate(originalDateString: forecast.dtTxt).last ?? "")
                .font(.title3)
            Text(iconMap[forecast.weather.first?.main ?? "Default"] ?? "❓")
                .font(.title3)
                .padding()
            Text("\(Int(forecast.main.temp)) C°")
                .bold()
        }.frame(maxHeight: 200).padding()
    }
    
    func formatDate(originalDateString: String) -> [String]! {
        let originalFormat = DateFormatter()
        originalFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = originalFormat.date(from: originalDateString)
        
        let dayFormat = DateFormatter()
        let timeFormat = DateFormatter()
        dayFormat.dateFormat = "HH:mm"
        timeFormat.dateFormat = "EEEE"
        if let date = date {
            let newDayString = dayFormat.string(from: date)
            let newTimeString = timeFormat.string(from: date)
            return [newTimeString, newDayString]
        } else {
            return ["", ""]
        }
    }
}

private let iconMap = [
    "Drizzle" : "🌧️",
    "Thunderstorm" : "⛈️",
    "Rain" : "🌧️",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "☁️",
    "Default": "❓"
]
