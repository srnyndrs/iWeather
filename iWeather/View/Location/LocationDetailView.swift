//
//  LocationDetailView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationDetailView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            WeatherInfoView(weatherViewModel: viewModel)
        }
    }
}
