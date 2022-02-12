//
//  MapPlaceEditView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 30/01/2022.
//

import SwiftUI

struct MapPlaceEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: MapPlaceEditViewModel
    
    let location: MapLocation
    var onSave: (MapLocation) -> Void
    
    // @escpaing == "Will use it later, not called immediately"
    init(location: MapLocation, onSave: @escaping (MapLocation) -> Void) {
        self.location = location
        self.onSave = onSave
        
        self._vm = StateObject(wrappedValue: MapPlaceEditViewModel(location: location))
        // State creates an instance of State property wrapper and assign it
        //        _name = State(initialValue: location.name)
        //        _description = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $vm.name)
                    TextField("Description", text: $vm.description)
                }
                
                Section("Nearby ...") {
                    switch vm.loadingState {
                    case .loading:
                        Text("Loading ...")
                    case .success:
                        ForEach(vm.pages, id: \.pageId) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again ...")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = vm.name
                    newLocation.description = vm.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    
}

struct MapPlaceEditView_Previews: PreviewProvider {
    static var previews: some View {
        MapPlaceEditView(location: MapLocation.example) { newLocation in }
    }
}
