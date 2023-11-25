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
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .stroke(.black)
            VStack(alignment: .center) {
                Text(formatDate(originalDateString: forecast.dtTxt).first ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Text(formatDate(originalDateString: forecast.dtTxt).last ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather.first?.icon ?? "")@2x.png")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50, maxHeight: 50)
                    case .failure:
                        Text(Constants.iconMap[forecast.weather.first?.main ?? "Default"] ?? "❓")
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(width: 50, height: 50)
                Text("\(Int(forecast.main.temp))°C")
                    .foregroundColor(.white)
                    .bold()
            }
        }.frame(width: 100, height: 180).padding(.horizontal, 10)
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
