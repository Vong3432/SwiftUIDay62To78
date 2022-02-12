//
//  ChallengeImportImageViewModel.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

extension ChallengeImportImageView {
    
    @MainActor
    class ChallengeImportImageViewModel: ObservableObject {
        @Published var image: Image?
        @Published var selectedImage: UIImage?
        @Published var showPicker = false
        @Published var name: String = ""
        @Published var currentCoordinate: CLLocationCoordinate2D?
        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1.12, longitude: 0.12), latitudinalMeters: 750, longitudinalMeters: 750)
        @Published var currentLocation: Location = Location(name: "Place", coordinate: CLLocationCoordinate2D(latitude: 1.12, longitude: 0.12))
        
        private let persistentController = CoreDataPersistentController.shared
        private let locationFetcher = LocationFetcher()
        
        init() {
            locationFetcher.start()
        }
        
        func loadImage() {
            guard let selectedImage = selectedImage else {
                return
            }
            
            guard let coordinate = locationFetcher.lastKnownLocation else { return }
            
            currentCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude , longitude: coordinate.longitude)
            region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            currentLocation = Location(name: "Place", coordinate: coordinate)
            
            image = Image(uiImage: selectedImage)
        }
        
        func save() {
            guard let selectedImage = selectedImage, name.isEmpty != true, let coordinate = currentCoordinate
            else { return }
            
            let uniqueId = UUID().uuidString
            
            if let jpegData = selectedImage.jpegData(compressionQuality: 0.8) {
                try? FileManager.encode(jpegData, to: uniqueId)
                
                let newPhoto = Photo(context: persistentController.container.viewContext)
                newPhoto.ref = uniqueId
                newPhoto.name = name
                newPhoto.longitude = NSNumber(value: coordinate.longitude)
                newPhoto.latitude = NSNumber(value: coordinate.latitude)
                
                persistentController.saveContext()
            }
        }
    }
}
