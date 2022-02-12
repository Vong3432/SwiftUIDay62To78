//
//  ChallengeViewModel.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import Foundation
import Combine
import UIKit
import SwiftUI

extension ChallengeView {
    
    @MainActor class ChallengeViewModel: ObservableObject {
        @Published var showImportSheet = false
        @Published var photos = [PhotoModel]()
        private var cancellables = Set<AnyCancellable>()
        
        private let controller = CoreDataPersistentController.shared
        
        init() {
            load()
        }
        
        func load() {
            let fetchRequest = Photo.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Photo.name, ascending: true)]
            
            CDPublisher(request: fetchRequest, context: controller.container.viewContext)
                .map { returnedPhotos in
                    return returnedPhotos.map { returnedPhoto in
                        PhotoModel(ref: returnedPhoto.wrappedRef, name: returnedPhoto.wrappedName, latitude: returnedPhoto.wrappedLatitude, longitude: returnedPhoto.wrappedLongitude)
                    }
                }
                .receive(on: DispatchQueue.main)
                .sink { _ in } receiveValue: { [weak self] returnedPhotos in
                    self?.photos = returnedPhotos
                }
                .store(in: &cancellables)
            
        }
    }
}
