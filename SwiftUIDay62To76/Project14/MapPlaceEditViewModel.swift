//
//  EditViewModel.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 03/02/2022.
//

import Foundation

extension MapPlaceEditView {
    
    @MainActor
    class MapPlaceEditViewModel: ObservableObject {
        
        let location: MapLocation
        @Published private(set) var loadingState = LoadingState.loading
        @Published private(set) var pages = [Page]()
        @Published var name: String
        @Published var description: String
        
        init(location: MapLocation) {
            self.location = location
            self.name = location.name
            self.description = location.description
            
            Task {
                await self.fetchNearbyPlaces()
            }
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .success
            } catch let error {
                self.loadingState = .failed
                print("err:" + String(describing: error.localizedDescription))
            }
            
        }
    }
    
}
