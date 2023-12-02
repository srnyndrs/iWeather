//
//  TabBarView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherService: WeatherService
    
    var body: some View {
        TabView {
            VStack {
                // Main Weather Tab
                WeatherDetailsView(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel)
            }.tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            VStack {
                // Location Tab
                LocationListView(weatherService: weatherService, locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel)
            }.tabItem {
                VStack {
                    Image(systemName: "list.bullet")
                    Text("Locations")
                }
            }
            VStack {
                // Map Tab
                MapView(locationViewModel: locationViewModel)
            }.tabItem {
                VStack {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            }
        }.accentColor(.cyan)
    }
}
