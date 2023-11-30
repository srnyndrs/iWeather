//
//  WeatherMarker.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import SwiftUI

struct WeatherMarker: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .stroke(.secondary, lineWidth: 1)
                .foregroundColor(.black)
            VStack(alignment: .center, spacing: 0) {
                //Text(weatherViewModel.weatherIcon).font(.title)
                /*AsyncImage(url: URL(string: weatherViewModel.weatherIconImage)) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image.resizable()
                            .clipped()
                            .frame(maxWidth: 50, maxHeight: 50)
                    case .failure:
                        Text(Constants.iconMap[weatherViewModel.weatherIcon ] ?? "❓")
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(width: 50, height: 50)*/
                Text("\(weatherViewModel.cityName)")
                    .font(.system(size: 8))
                    .bold()
                AsyncImage(url: URL(string: weatherViewModel.weatherIconImage)) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView().frame(width: 50, height: 50)
                }
                Text(" \(weatherViewModel.temperature)°C")
                    .font(.footnote)
                    
            }.padding(2).foregroundColor(.white)
        }.frame(width: 20, height: 20)
        .task {
            await weatherViewModel.refresh()
        }
    }
}


#Preview {
    WeatherMarker(weatherViewModel: WeatherViewModel(weatherService: WeatherService(), location: Constants.MockUserLocation.coordinate))
}
