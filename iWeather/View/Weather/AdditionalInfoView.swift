//
//  AdditionalInfoView.swift
//  iWeather
//
//  Created by Suranyi on 24/11/2023.
//

import SwiftUI

struct AdditionalInfoView: View {
    var wind: String
    var humidity: String
    var sunrise: String
    var sunset: String
    
    var body: some View {
        LazyVStack {
            HStack {
                Spacer()
                AdditionalCardView(systemName: "wind", text: "wind", value: "\(wind) m/s", color: Color.gray)
                Spacer()
                AdditionalCardView(systemName: "humidity", text: "humidity", value: "\(humidity)%", color: Color.cyan)
                Spacer()
            }
            HStack {
                Spacer()
                AdditionalCardView(systemName: "sun.horizon", text: "sunrise", value: "\(sunrise)", color: Color.yellow)
                Spacer()
                AdditionalCardView(systemName: "moon.fill", text: "sunset", value: "\(sunset)", color: Color.indigo)
                Spacer()
            }
        }
    }
}

#Preview {
    AdditionalInfoView(wind: "5", humidity: "5", sunrise: "07:00", sunset: "17:00")
}
