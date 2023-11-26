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
                Text(formatDate((Int(forecast.dt ?? 0)) + timezone).first ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Text(formatDate((Int(forecast.dt ?? 0)) + timezone).last ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                /*AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "")@2x.png")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image.resizable()
                            .clipped()
                            .frame(maxWidth: 50, maxHeight: 50)
                    case .failure:
                        Text(Constants.iconMap[forecast.weather?.first?.icon ?? "Default"] ?? "❓")
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(width: 50, height: 50)*/
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather?.first?.icon ?? "")@2x.png")) { image in
                    image
                        .resizable()
                        .clipped()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
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
    
    func formatDate(_ millis: Int) -> [String]! {
        let date = Date(timeIntervalSince1970: Double(millis))

        let dayFormat = DateFormatter()
        let timeFormat = DateFormatter()
        dayFormat.dateFormat = "HH:mm"
        timeFormat.dateFormat = "EEEE"
        
        let newDayString = dayFormat.string(from: date)
        let newTimeString = timeFormat.string(from: date)
        return [newTimeString, newDayString]

    }
}
