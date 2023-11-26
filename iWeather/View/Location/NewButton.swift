//
//  FloatingButton.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct NewButton: View {
    //@EnvironmentObject var locationHolder: LocationHolder
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    
    var body: some View {
        /*Spacer()
        HStack {
            NavigationLink(destination: LocationEditView(locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel, passedLocation: nil)){
                Text("New location")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }*/
        NavigationLink(destination: LocationEditView(locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel, passedLocation: nil).navigationTitle("New location")){
            Text("New")
        }
    }
}
