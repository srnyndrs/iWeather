//
//  WeatherInfoView.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import SwiftUI

struct WeatherInfoView: View {
    var cityName: String
    var temperature: String
    var weatherIcon: String
    var weatherIconId: String
    var weatherDescription: String
    
    var body: some View {
        LazyVStack {
            Spacer()
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center, spacing: 0){
                    LazyHStack(alignment: .center){
                        Image(systemName: "mappin.and.ellipse")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text(cityName)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    Text(temperature + "°C")
                        .font(.system(size: 48))
                        .foregroundColor(.white)
                        .padding(.top, 12)
                        .bold()
                    Text(weatherDescription)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }
                AsyncImage(url: URL(string: weatherIconId)) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 125, height: 125)
                } placeholder: {
                    ProgressView().frame(width: 125, height: 125)
                }
                Spacer()
            }
            Spacer()
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing
            )
        ).cornerRadius(5)
        .padding(.horizontal, 6)
    }
}

#Preview {
    WeatherInfoView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherIconId: "https://openweathermap.org/img/wn/01n@2x.png", weatherDescription: "Sunny")
}
