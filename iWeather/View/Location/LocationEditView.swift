//
//  LocationEditView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI

struct LocationEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var geocodingViewModel: GeocodingViewModel
    @State private var searchText = ""
    @State var selectedLocation: Location?
    @State var nameText: String
    @State var latitudeText: String
    @State var longitudeText: String
    @State var nameValidation: Bool
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
        _nameValidation = State(initialValue: true)
        _latValidation = State(initialValue: true)
        _lonValidation = State(initialValue: true)
        if let item = passedLocation {
            _selectedLocation = State(initialValue: item)
            _nameText = State(initialValue: item.name ?? "")
            _latitudeText = State(initialValue: "\(item.latitude)" )
            _longitudeText = State(initialValue: "\(item.longitude)" )
        } else {
            _nameText = State(initialValue: "")
            _latitudeText = State(initialValue: "")
            _longitudeText = State(initialValue: "")
        }
    }
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search for a city", text: $geocodingViewModel.searchText)
                        .font(.subheadline)
                    Image(systemName: "arrow.counterclockwise")
                        .onTapGesture {
                            geocodingViewModel.searchText = ""
                            self.nameText = ""
                            self.latitudeText = ""
                            self.longitudeText = ""
                            geocodingViewModel.resetSearch()
                        }
                }
                .onSubmit(of: .text){
                    Task { await self.geocodingViewModel.searchForLocation() }
                }
                Section(header: Text("Location")) {
                    TextField("Name", text: $nameText)
                        .onChange(of: nameText) { oldValue, newValue in
                            if newValue.isEmpty {
                                nameValidation = true
                            } else {
                                nameValidation = false
                            }
                        }
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
                        .disabled(nameValidation || latValidation || lonValidation)
                }
                Section(header: Text("Search results")) {
                    List(geocodingViewModel.results, id: \.address) { data in
                        Text("\(data.address)")
                            .onTapGesture {
                                self.nameText = data.city
                                self.latitudeText = "\(data.latitude)"
                                self.longitudeText = "\(data.longitude)"
                            }
                    }
                }
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
        
        locationViewModel.addLocation(name: nameText, lat: latitude!, lon: longitude!)
        //locationHolder.saveContext(viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
