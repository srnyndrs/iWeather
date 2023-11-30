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
            LazyVStack(alignment: .center, spacing: 0) {
                LazyHStack{
                    Text("\(weatherViewModel.cityName)")
                        .font(.system(size: 8))
                        .bold()
                }
                AsyncImage(url: URL(string: weatherViewModel.weatherIconImage)) { image in
                    image
                        .resizable()
                        .clipped()
                        .frame(width: 25, height: 25)
                } placeholder: {
                    ProgressView().frame(width: 25, height: 25)
                }
                Text(" \(weatherViewModel.temperature)°C")
                    .font(.system(size: 10))
            }.padding(4).foregroundColor(.white)
        }.frame(minWidth: 50, minHeight: 50)
        .task {
            await weatherViewModel.refresh()
        }
    }
}


#Preview {
    WeatherMarker(weatherViewModel: WeatherViewModel(weatherService: WeatherService(), location: Constants.MockUserLocation.coordinate))
}
