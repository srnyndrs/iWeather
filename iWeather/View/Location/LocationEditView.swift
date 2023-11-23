//
//  LocationEditView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    /*@Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var locationHolder: LocationHolder*/
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    @State private var searchText = ""
    @State var selectedLocation: Location?
    @State var name: String
    @State var latitudeText: String
    @State var longitudeText: String
    @State var latValidation: Bool
    @State var lonValidation: Bool
    
    var latitude: Double? {
        if let value = Double(latitudeText) {
            return value
        } else {
            return nil
        }
    }

    var longitude: Double? {
        if let value = Double(longitudeText) {
            return value
        } else {
            return nil
        }
    }
    
    init(locationViewModel: LocationViewModel, geocodingViewModel: GeocodingViewModel, passedLocation: Location?) {
        self.locationViewModel = locationViewModel
        self.geocodingViewModel = geocodingViewModel
        _latValidation = State(initialValue: false)
        _lonValidation = State(initialValue: false)
        if let item = passedLocation {
            _selectedLocation = State(initialValue: item)
            _name = State(initialValue: item.name ?? "")
            _latitudeText = State(initialValue: "\(item.latitude)" )
            _longitudeText = State(initialValue: "\(item.longitude)" )
        } else {
            _name = State(initialValue: "")
            _latitudeText = State(initialValue: "0")
            _longitudeText = State(initialValue: "0")
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Location")) {
                    TextField("Name", text: $name)
                    TextField("Latitude", text: $latitudeText)
                        .onChange(of: latitudeText) { oldValue, newValue in
                            if Double(newValue) == nil {
                                latValidation = true
                            } else {
                                latValidation = false
                            }
                        }
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Longitude", text: $longitudeText)
                        .onChange(of: longitudeText) { oldValue, newValue in
                            if Double(newValue) == nil {
                                lonValidation = true
                            } else {
                                lonValidation = false
                            }
                        }
                        .keyboardType(.numbersAndPunctuation)
                    Button("Save", action: saveAction)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(latValidation || lonValidation)
                }
            }
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $geocodingViewModel.searchText)
                        .font(.subheadline)
                }
                .padding(12)
                .background(.white)
                .padding()
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .onSubmit(of: .text){
                    Task { self.geocodingViewModel.fetchData() }
                }
                List(geocodingViewModel.results, id: \.address) { data in
                    Text("\(data.address)")
                        .onTapGesture {
                            self.name = data.city
                            self.latitudeText = "\(data.latitude)"
                            self.longitudeText = "\(data.longitude)"
                        }
                }
            }.onAppear {
                self.geocodingViewModel.fetchData()
            }
            Spacer()
        }
    }
    
    func saveAction() {
        //if selectedLocation == nil {
            //selectedLocation = Location(context: locationViewModel.container.viewContext)
        //}
        
        //selectedLocation?.name = name
        //selectedLocation?.latitude = latitude
        //selectedLocation?.longitude = longitude
        if latitude == nil {
            return
        }
        if longitude == nil {
            return
        }
        
        locationViewModel.addLocation(name: name, lat: latitude!, lon: longitude!)
        //locationHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
