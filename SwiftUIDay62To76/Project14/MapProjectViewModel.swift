//
//  MapProjectViewModel.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 01/02/2022.
//

import Foundation
import MapKit
import LocalAuthentication

extension MapProjectView {
    /**
     The main actor is responsible for running all user interface updates, and adding that attribute to the class means we want all its code – any time it runs anything, unless we specifically ask otherwise – to run on that main actor. This is important because it’s responsible for making UI updates, and those must happen on the main actor. In practice this isn’t quite so easy, but we’ll come to that later on.
     */
    @MainActor class MapProjectViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [MapLocation]
        @Published var selectedPlace: MapLocation?
        @Published var isUnlocked = false
        @Published var showError = false
        @Published var errorMsg: String?
        
        let savePath = "SavedPlaces"
        
        init() {
            do {
                locations = try FileManager.decode([MapLocation].self, from: savePath)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            // create new location
            let newLocation = MapLocation(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(location: MapLocation) {
            guard let selectedPlace = selectedPlace else {
                return
            }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func save() {
            do {
                try FileManager.encode(locations, to: savePath)
            } catch let error {
                print("[MapProjectViewModel.save.err]: \(String(describing: error.localizedDescription))")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticatedError in
                    
                    // this will create a new bg task and use it to perform some work on main thread
                    //                    Task {
                    //                            await MainActor.run {
                    //                                self.isUnlocked = true
                    //                            }
                    //                        }
                    
                    // this make sure task will directly run on main thread [better]
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            // error
                            self.showError = true
                            self.errorMsg = authenticatedError?.localizedDescription
                        }
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
