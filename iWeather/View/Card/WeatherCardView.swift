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
    var weatherDescription: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(cityName)
                .font(.system(size: 12))
            Spacer()
            Text(temperature + " C°")
                .font(.system(size: 12))
                .bold()
            Spacer()
            Text(weatherIcon)
                .font(.system(size: 20))
            Spacer()
            Text(weatherDescription)
                .font(.system(size: 12))
            Spacer()
        }
    }
}

#Preview {
    WeatherCardView(cityName: "Budapest", temperature: "12", weatherIcon: "☀️", weatherDescription: "Clear")
}
