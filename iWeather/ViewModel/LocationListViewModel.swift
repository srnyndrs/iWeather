//
//  LocationViewModel.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import Foundation
import CoreData

class LocationListViewModel: ObservableObject {

    @Published var locations: [Location] = []
    
    func getAllLocation() {
        locations = PersistenceController.shared.getAllLocation()
    }
    
    func addLocation(name: String, lat: Double, lon: Double) {
        PersistenceController.shared.addLocation(name: name, lat: lat, lon: lon)
        getAllLocation()
    }
    
    func updateGoal() {
        PersistenceController.shared.saveContext()
        getAllLocation()
    }
    
    func deleteLocation(location: Location) {
        PersistenceController.shared.deleteLocation(location: location)
        getAllLocation()
    }
}
