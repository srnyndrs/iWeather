//
//  WeatherCardView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct WeatherCardView: View {    
    var cityName: String
    var temperature: String
    var weatherIcon: String
    var weatherIconId: String
    var weatherDescription: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(cityName)
                .font(.system(size: 12))
            Spacer()
            Text(temperature + "°C")
                .font(.system(size: 12))
                .bold()
            Spacer()
            AsyncImage(url: URL(string: weatherIconId)) { phase in
                switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 25, height: 25)
                    case .success(let image):
                        image.resizable()
                            .clipped()
                            .frame(maxWidth: 25, maxHeight: 25)
                    case .failure:
                        Text(weatherIcon)
                            .frame(width: 25, height: 25)
                    @unknown default:
                        EmptyView()
                            .frame(width: 25, height: 25)
                }
            }.frame(width: 25, height: 25)
            Spacer()
            Text(weatherDescription)
                .font(.system(size: 12))
            Spacer()
        }
    }
}

#Preview {
    WeatherCardView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherIconId: "01d", weatherDescription: "Clear")
}
