//
//  TabBarView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI

struct MainView: View {
    //@Environment(\.managedObjectContext) private var viewContext
    //@EnvironmentObject var locationHolder: LocationHolder
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherService: WeatherService
    
    var body: some View {
        TabView {
            VStack{
                WeatherScene(weatherViewModel: weatherViewModel, forecastViewModel: forecastViewModel)
            }.tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            VStack {
                LocationScene(weatherService: weatherService, locationViewModel: locationViewModel)
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("Locations")
            }
            VStack {
                MapScene(locationViewModel: locationViewModel, userLocation: locationManager.userLocation, cameraPosition: locationManager.userLocation.cameraPosition)
            }.tabItem {
                Image(systemName: "map.fill")
                Text("Map")
            }
        }
    }
}
