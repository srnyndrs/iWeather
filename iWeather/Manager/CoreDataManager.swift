//
//  CoreDataManager.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        // pass the data model filename to NSPersistentContainer initializer
        persistentContainer = NSPersistentContainer(name: "LocationDataModel")
      
        // load any persistent stores
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    // save the changes on your context to the persistent store
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    // fetch all the goals data from Goals Entity using NSFetchRequest
    func getAllLocation() -> [Location] {
        let request = NSFetchRequest<Location>(entityName: "Location")

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    // add new goal by creating a new variable and set the Goals context
    // to our viewcontext, assign the data and don't forget to save the
    // changes using saveContext function
    func addLocation(name: String, lat: Double, lon: Double) {
        let newLocation = Location(context: viewContext)
        newLocation.name = name
        newLocation.latitude = lat
        newLocation.longitude = lon
        saveContext()
    }

    // delete the goals based on the selected goal you want to delete
    func deleteLocation(location: Location) {
        viewContext.delete(location)
        saveContext()
    }
}
