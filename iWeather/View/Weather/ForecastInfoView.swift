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
        VStack {
            List(forecastViewModel.forecast) { forecast in
                LazyHStack {
                    Text("\(forecast.dt)")
                    Text("\(forecast.main.temp) C°")
                }
            }
        }
        .padding()
        .background(Color.blue)
    }
}
