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
    
    var body: some View {
        if weatherViewModel.weatherService.authorizationStatus == .authorizedWhenInUse {
            TabView {
                VStack{
                    WeatherScene(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel)
                }.tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                VStack {
                    LocationScene()
                }.tabItem {
                    Image(systemName: "list.bullet")
                    Text("Locations")
                }
                VStack {
                    MapScene(userLocation: weatherViewModel.weatherService.userLocation, cameraPosition: weatherViewModel.weatherService.userLocation.cameraPosition)
                }.tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            }.task {
                await weatherViewModel.refresh()
                await forecastViewModel.refresh()
            }
        }
        else {
            Text("The location is not granted!")
        }
    }
}
