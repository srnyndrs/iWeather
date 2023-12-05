//
//  ForecastInfoView.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import SwiftUI

struct ForecastInfoView: View {
    var forecast: [Forecast]
    var timezone: Int
    
    var body: some View {
        LazyVStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(forecast) { forecast in
                        ForecastCardView(forecast: forecast, timezone: timezone)
                    }
                }
            }.frame(maxHeight: 150).padding(.horizontal, 6)
        }
    }
}
