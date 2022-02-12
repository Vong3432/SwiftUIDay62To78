//
//  MapLocation.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 30/01/2022.
//

import Foundation
import CoreLocation

struct MapLocation: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = MapLocation(id: UUID(), name: "Buckingham Palace", description: "Where someone lives", latitude: 51.501, longitude: -0.141)
    
    // write custom equal compare because Swift will compare every properties of MapLocation struct by default
    // use id to compare because it is unique
    static func ==(lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.id == rhs.id
    }
}
