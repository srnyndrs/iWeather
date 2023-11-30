//
//  WeatherCardView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationRowView: View {    
    var cityName: String
    var temperature: String
    var weatherIcon: String
    var weatherIconId: String
    var weatherDescription: String
    
    var body: some View {
        HStack {
            VStack {
                /*AsyncImage(url: URL(string: weatherIconId)) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image.resizable()
                            .frame(width: 50, height: 50)
                            .border(.red)
                    case .failure:
                        Text(weatherIcon)
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                            .frame(width: 50, height: 50)
                    }
                }.frame(width: 50, height: 50)*/
                AsyncImage(url: URL(string: weatherIconId)) { image in
                    image
                        .resizable()
                        .clipped()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            }
            VStack(spacing: 8) {
                Text(cityName)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: 150, alignment: .leading)
                Text(weatherDescription)
                    .font(.subheadline)
                    .frame(maxWidth: 150, alignment: .leading)
            }
            Spacer()
            VStack {
                HStack {
                    Text(temperature + "°C")
                        .font(.title)
                        .bold()
                    
                }
            }.padding(.horizontal, 10)
        }
    }
}

#Preview {
    LocationRowView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherIconId: "01d", weatherDescription: "Clear")
}
