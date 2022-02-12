//
//  Photo+CoreDataProperties.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var name: String?
    @NSManaged public var ref: String?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?

    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedRef: String {
        ref ?? "Unknown ref"
    }
    
    public var wrappedLatitude: Double {
        latitude?.doubleValue ?? 0.0
    }
    
    public var wrappedLongitude: Double {
        longitude?.doubleValue ?? 0.0
    }
}

extension Photo : Identifiable {

}
