//
//  Location.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 29/01/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
