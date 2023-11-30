//
//  MapScene.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @State var cameraPosition: MapCameraPosition
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(locationViewModel.locations) { location in
                let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                let locationItem = locationViewModel.locationMap[location] ?? LocationItem(weatherService: locationViewModel.weatherService, location: placemark.coordinate)
                Annotation("", coordinate: placemark.coordinate) {
                    WeatherMarker(weatherViewModel: locationItem.weatherViewModel)
                }
            }
        }.mapStyle(.hybrid)
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
    }
}
