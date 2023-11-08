//
//  LocationEditView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var locationHolder: LocationHolder
    
    @State var selectedLocation: Location?
    @State var name: String
    @State var latitude: Double
    @State var longitude: Double
    
    init(passedLocation: Location?) {
        if let item = passedLocation {
            _selectedLocation = State(initialValue: item)
            _name = State(initialValue: item.name ?? "")
            _latitude = State(initialValue: item.latitude )
            _longitude = State(initialValue: item.longitude )
        } else {
            _name = State(initialValue: "")
            _latitude = State(initialValue: 0)
            _longitude = State(initialValue: 0)
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Location")) {
                TextField("Name", text: $name)
                TextField("Latitude", value: $latitude, formatter: NumberFormatter())
                TextField("Longitude", value: $longitude, formatter: NumberFormatter())
            }
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func saveAction() {
        withAnimation {
            if selectedLocation == nil {
                selectedLocation = Location(context: viewContext)
            }
            
            selectedLocation?.name = name
            selectedLocation?.latitude = latitude
            selectedLocation?.longitude = longitude
            
            locationHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    LocationEditView(passedLocation: Location())
}
