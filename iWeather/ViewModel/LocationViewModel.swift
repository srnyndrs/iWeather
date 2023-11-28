//
//  LocationViewModel.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import Foundation
import CoreData
import MapKit

class LocationViewModel: ObservableObject {
    var weatherService: WeatherService
    let container: NSPersistentContainer
    @Published var locations: [Location] = []
    @Published var locationMap: [Location : LocationItem] = [:]
    
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
        print("Fetch locations")
        let request = NSFetchRequest<Location>(entityName: "Location")
        do {
            locations = try container.viewContext.fetch(request)
            for location in locations {
                locationMap.updateValue(LocationItem(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)), forKey: location)
            }
        } catch let error {
            print(error)
        }
    }
    
    func addLocation(name: String, lat: Double, lon: Double) {
        let newLocation = Location(context: container.viewContext)
        newLocation.name = name
        newLocation.latitude = lat
        newLocation.longitude = lon
        locations.append(newLocation)
        locationMap.updateValue(LocationItem(weatherService: weatherService, location: CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude)), forKey: newLocation)
        saveData()
    }
    
    func deleteLocation(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = locations[index]
        locationMap.removeValue(forKey: entity)
        container.viewContext.delete(entity)
        locations.remove(at: index)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func getLocationItem(location: Location) -> LocationItem? {
        return locationMap[location]
    }
    
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
