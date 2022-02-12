//
//  Photo.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import Foundation
import SwiftUI
import MapKit

struct PhotoModel: Codable, Identifiable {
    var id: String {
        ref
    }
    let ref: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
