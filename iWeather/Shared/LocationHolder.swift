//
//  SwiftUIView.swift
//  iWeather
//
//  Created by Suranyi on 08/11/2023.
//

import SwiftUI
import CoreData

class LocationHolder: ObservableObject{
    
    init(_ context: NSManagedObjectContext) {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
