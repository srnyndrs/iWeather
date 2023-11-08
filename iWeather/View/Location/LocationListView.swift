//
//  ContentView.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import SwiftUI
import CoreData

struct LocationListView: View {
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
                            NavigationLink(destination: LocationEditView(passedLocation: item).environmentObject(locationHolder)) {
                                Text(item.name ?? "")
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    LocationListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
