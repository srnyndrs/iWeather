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
    //@Environment(\.managedObjectContext) private var viewContext
    //@EnvironmentObject var locationHolder: LocationHolder

    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Location>*/

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(locationViewModel.locations) { item in
                            /*NavigationLink(destination: LocationEditView(passedLocation: item).environmentObject(locationHolder)) {
                                Text(item.name ?? "")
                            }*/
                            //let weatherViewModel = WeatherViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                            //let foreCastViewModel = ForecastViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                            let weatherViewModel = locationViewModel.getLocationItem(location: item)?.weatherViewModel ?? WeatherViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                            let foreCastViewModel = locationViewModel.getLocationItem(location: item)?.forecastViewModel ?? ForecastViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                            NavigationLink(destination: WeatherDetailsView(weatherViewModel: weatherViewModel, forecastViewModel: foreCastViewModel)) {
                                WeatherListItem(weatherViewModel: weatherViewModel)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    FloatingButton(locationViewModel: locationViewModel)
                }
            }.navigationTitle("Locations")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        locationViewModel.deleteLocation(indexSet: offsets)
    }
}
