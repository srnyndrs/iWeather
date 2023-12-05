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
    var weatherIconId: String
    var weatherDescription: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: weatherIconId)) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
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
            }.padding(.horizontal, 8)
        }
    }
}

#Preview {
    LocationRowView(cityName: "Budapest", temperature: "12", weatherIconId: "01d", weatherDescription: "Clear")
}
