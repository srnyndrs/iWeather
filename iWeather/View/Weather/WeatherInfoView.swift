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
    var weatherDescription: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(cityName)
                .font(.largeTitle)
            Text(temperature + " C°")
                .font(.system(size: 70))
                .bold()
            Text(weatherIcon)
                .font(.largeTitle)
                .padding()
            Text(weatherDescription)
        }.padding()
    }
}

#Preview {
    WeatherInfoView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherDescription: "Sunny")
}
