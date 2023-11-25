//
//  ForecastInfoView.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import SwiftUI

struct ForecastInfoView: View {
    var forecast: [Forecast]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(forecast) { forecast in
                        ForecastCardView(forecast: forecast)
                    }
                }
            }.frame(height: 100).padding(.horizontal, 6)
        }
    }
}
