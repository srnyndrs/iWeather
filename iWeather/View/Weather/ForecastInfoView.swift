//
//  ForecastInfoView.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import SwiftUI

struct ForecastInfoView: View {
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(forecastViewModel.forecast) { forecast in
                    ForecastCardView(forecast: forecast)
                    Spacer()
                }
            }
        }.frame(height: 100)
    }
}
