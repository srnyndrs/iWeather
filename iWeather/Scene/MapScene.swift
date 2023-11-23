//
//  MapScene.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI
import MapKit

struct MapScene: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @State var userLocation: UserLocation
    @State var cameraPosition: MapCameraPosition
    @State private var selection: MKMapItem?
    @State private var showDetails: Bool = false
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selection) {
            UserAnnotation()
            ForEach(locationViewModel.locations) { location in
                let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                let locationItem = locationViewModel.locationMap[location] ?? LocationItem(weatherService: locationViewModel.weatherService, location: placemark.coordinate)
                //Marker(location.name ?? "", coordinate: placemark.coordinate)
                Annotation(location.name ?? "", coordinate: placemark.coordinate) {
                    WeatherMarker(weatherViewModel: locationItem.weatherViewModel)
                }
            }
            
        }
        .onChange(of: selection, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            MarkerDetailsView(selection: $selection, show: $showDetails)
                .presentationDetents([.height(150)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(150)))
                .presentationCornerRadius(12)
        })
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
    }
}
