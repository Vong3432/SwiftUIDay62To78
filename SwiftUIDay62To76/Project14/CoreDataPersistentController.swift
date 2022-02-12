//
//  CoreDataPersistentContainer.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import Foundation
import CoreData

class CoreDataPersistentController {
    static let shared = CoreDataPersistentController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Photo")
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
