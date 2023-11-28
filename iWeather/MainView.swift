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
                WeatherScene(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel)
            }.tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            VStack {
                LocationScene(weatherService: weatherService, locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel)
            }.tabItem {
                VStack {
                    Image(systemName: "list.bullet")
                    Text("Locations")
                }
            }
            VStack {
                MapScene(locationViewModel: locationViewModel, userLocation: locationManager.userLocation, cameraPosition: locationManager.userLocation.cameraPosition)
            }.tabItem {
                VStack{
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            }
        }.accentColor(.cyan)
    }
}
