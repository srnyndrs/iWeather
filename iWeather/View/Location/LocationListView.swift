//
//  ContentView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI
import CoreData
import CoreLocation

struct LocationListView: View {
    @ObservedObject var weatherService: WeatherService
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    //@Environment(\.managedObjectContext) private var viewContext
    //@EnvironmentObject var locationHolder: LocationHolder

    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Location>*/

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(locationViewModel.locations) { item in
                        /*NavigationLink(destination: LocationEditView(passedLocation: item).environmentObject(locationHolder)) {
                         Text(item.name ?? "")
                         }*/
                        //let weatherViewModel = WeatherViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                        //let foreCastViewModel = ForecastViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                        let weatherViewModel = locationViewModel.getLocationItem(location: item)?.weatherViewModel ?? WeatherViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                        let foreCastViewModel = locationViewModel.getLocationItem(location: item)?.forecastViewModel ?? ForecastViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                        NavigationLink(destination: WeatherDetailsView(weatherViewModel: weatherViewModel, forecastViewModel: foreCastViewModel).navigationTitle(item.name ?? "")) {
                            WeatherListItem(weatherViewModel: weatherViewModel, locationName: item.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }.listRowBackground(
                    LinearGradient(gradient: Gradient(colors: [.blue,.cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                ).listRowSeparator(.visible)
            }
            .listStyle(.insetGrouped)
            //.environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Locations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NewLocationButton(locationViewModel: locationViewModel, geocodingViewModel: geocodingViewModel)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        locationViewModel.deleteLocation(indexSet: offsets)
    }
}
