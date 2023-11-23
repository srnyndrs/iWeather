//
//  LocationScene.swift
//  iWeather
//
//  Created by Suranyi on 06/11/2023.
//

import SwiftUI

struct LocationScene: View {
    //@Environment(\.managedObjectContext) private var viewContext
    //@EnvironmentObject var locationHolder: LocationHolder
    @ObservedObject var weatherService: WeatherService
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    
    var body: some View {
        LocationListView(weatherService: weatherService, locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel)
            //.environment(\.managedObjectContext, viewContext)
            //.environmentObject(locationHolder)
    }
}
