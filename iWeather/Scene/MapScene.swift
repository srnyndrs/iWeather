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
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var selection: MKMapItem?
    @State private var showDetails: Bool = false
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selection) {
            UserAnnotation()
            ForEach(results, id: \.self) { item in
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }
            ForEach(locationViewModel.locations) { location in
                let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                Marker(location.name ?? "", coordinate: placemark.coordinate)
            }
            
        }
        .overlay(alignment: .top) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText)
                    .font(.subheadline)
            }
            .padding(12)
            .background(.white)
            .padding()
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .onSubmit(of: .text){
            Task { await searchForPlace() }
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

extension MapScene {
    func searchForPlace() async {
        let request = MKLocalSearch.Request()
        request.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(.world)
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
}
