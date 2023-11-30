//
//  FloatingButton.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct NewLocationButton: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    
    var body: some View {
        NavigationLink(destination: LocationFormView(locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel).navigationTitle("New location")){
            Text("New")
        }
    }
}
