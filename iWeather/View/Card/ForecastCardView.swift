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
                Text(formatDate((Int(forecast.dt ?? 0))).first ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Text(formatDate((Int(forecast.dt ?? 0))).last ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                /*AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "").png")) { image in
                    image
                        .resizable()
                        .clipped()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)*/
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "")@2x.png")) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView().frame(width: 50, height: 50)
                }
                Text("\(Int(forecast.main?.temp ?? 0))°C")
                    .foregroundColor(.white)
                    .bold()
            }.frame(width: 100, height: 180)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(5)
        .padding(.horizontal, 10)
    }
    
    func formatDate(_ seconds: Int) -> [String]! {
        let date = Date(timeIntervalSince1970: Double(seconds))

        let dayFormat = DateFormatter()
        let timeFormat = DateFormatter()
        
        dayFormat.timeZone = TimeZone(secondsFromGMT: timezone)
        timeFormat.timeZone = TimeZone(secondsFromGMT: timezone)
        
        dayFormat.dateFormat = "HH:mm"
        timeFormat.dateFormat = "EEEE"
        
        let newDayString = dayFormat.string(from: date)
        let newTimeString = timeFormat.string(from: date)
        return [newTimeString, newDayString]
    }
}
