//
//  LocationViewModel.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import Foundation
import CoreData

class LocationViewModel: ObservableObject {
    public var weatherService: WeatherService
    let container: NSPersistentContainer
    @Published var locations: [Location] = []
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        self.container = NSPersistentContainer(name: "iWeather")
        container.loadPersistentStores() { (description, error) in
            if let error = error {
                print(error)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        fetchLocations()
    }
    
    func fetchLocations() {
        let request = NSFetchRequest<Location>(entityName: "Location")
        
        do {
            locations = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func addLocation(name: String, lat: Double, lon: Double) {
        let newLocation = Location(context: container.viewContext)
        newLocation.name = name
        newLocation.latitude = lat
        newLocation.longitude = lon
        saveData()
    }
    
    func deleteLocation(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = locations[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchLocations()
        } catch let error {
            print(error)
        }
    }
    
}
