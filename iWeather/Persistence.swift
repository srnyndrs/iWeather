//
//  Persistence.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "iWeather")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllLocation() -> [Location] {
        let request = NSFetchRequest<Location>(entityName: "Location")

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    func addLocation(name: String, lat: Double, lon: Double) {
        let newLocation = Location(context: viewContext)
        newLocation.name = name
        newLocation.latitude = lat
        newLocation.longitude = lon
        saveContext()
    }

    func deleteLocation(location: Location) {
        viewContext.delete(location)
        saveContext()
    }
}
