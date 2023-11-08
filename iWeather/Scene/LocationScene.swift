//
//  LocationScene.swift
//  iWeather
//
//  Created by Suranyi on 06/11/2023.
//

import SwiftUI

struct LocationScene: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var locationHolder: LocationHolder
    @ObservedObject var weatherService: WeatherService
    
    var body: some View {
        LocationListView(weatherService: weatherService)
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(locationHolder)
    }
}
