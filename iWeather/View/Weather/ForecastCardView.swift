//
//  ForecastCardView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct ForecastCardView: View {
    var forecast: Forecast
    var timezone: Int
    
    var body: some View {
        LazyHStack {
            LazyVStack(alignment: .center) {
                Text(formatDateToDay(forecast.dt ?? 0))
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Text(formatDateToTime(forecast.dt ?? 0))
                    .font(.headline)
                    .foregroundColor(.white)
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "")@2x.png")) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                Text("\(Int(forecast.main?.temp ?? 0))°C")
                    .foregroundColor(.white)
                    .bold()
            }.frame(width: 100, height: 180)
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(5)
        .padding(.horizontal, 10)
    }
    
    func formatDateToTime(_ seconds: Int) -> String {
        if seconds == 0 {
            return "00:00"
        }
        let date = Date(timeIntervalSince1970: Double(seconds))
        let timeFormat = DateFormatter()
        timeFormat.timeZone = TimeZone(secondsFromGMT: timezone)
        timeFormat.dateFormat = "HH:mm"
        return timeFormat.string(from: date)
    }
    
    func formatDateToDay(_ seconds: Int) -> String {
        if seconds == 0 { return "Unknown" }
        let date = Date(timeIntervalSince1970: Double(seconds))
        let dayFormat = DateFormatter()
        dayFormat.timeZone = TimeZone(secondsFromGMT: timezone)
        dayFormat.dateFormat = "EEEE"
        return dayFormat.string(from: date)
    }
}
