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
        ZStack(alignment:.top){
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .stroke(.black)
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center, spacing: 0){
                    HStack(alignment: .center){
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
                Spacer()
                AsyncImage(url: URL(string: weatherIconId)) { phase in
                    switch phase {
                        case .empty:
                            Image(systemName: "photo")
                                .frame(width: 100, height: 100)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        case .failure:
                            Text(weatherIcon)
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                        @unknown default:
                            EmptyView()
                                .frame(width: 100, height: 100)
                    }
                }.frame(width: 100, height: 100)
                Spacer()
            }.padding()
        }.frame(height: 100).padding(.horizontal, 10)
    }
}

#Preview {
    WeatherInfoView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherIconId: "10a", weatherDescription: "Sunny")
}
