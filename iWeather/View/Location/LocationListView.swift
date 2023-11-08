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
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var locationHolder: LocationHolder

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Location>

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(items) { item in
                            /*NavigationLink(destination: LocationEditView(passedLocation: item).environmentObject(locationHolder)) {
                                Text(item.name ?? "")
                            }*/
                            let viewModel = WeatherViewModel(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
                            NavigationLink(destination: LocationDetailView(viewModel: viewModel).environmentObject(locationHolder)) {
                                WeatherCardView(weatherViewModel: viewModel).task {
                                    await viewModel.refresh()
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    FloatingButton()
                        .environmentObject(locationHolder)
                }
            }.navigationTitle("Locations")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            locationHolder.saveContext(viewContext)
        }
    }
}
