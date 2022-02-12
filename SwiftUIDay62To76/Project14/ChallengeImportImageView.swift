//
//  ChallengeImportImageView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import SwiftUI
import MapKit

struct ChallengeImportImageView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ChallengeImportImageViewModel()
    
    var body: some View {
        VStack {
            
            if vm.image != nil {
                HStack {
                    Spacer()
                    Button("Save") {
                        vm.save()
                        dismiss()
                    }.disabled(vm.name.isEmpty)
                }.padding()
            }
            
            Spacer()
            
            if vm.image != nil {
                VStack {
                    vm.image!
                        .resizable()
                        .scaledToFit()
                    
                    if vm.currentCoordinate != nil {
                        Map(coordinateRegion: $vm.region, annotationItems: [vm.currentLocation]) { location in
                            MapMarker(coordinate: location.coordinate)
                        }
                    }
                    
                    TextField("Enter name", text: $vm.name)
                }.padding()
            }
            
            if vm.image == nil {
                Button("Import photo") {
                    vm.showPicker = true
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $vm.showPicker) {
            ImagePicker(image: $vm.selectedImage)
                .onChange(of: vm.selectedImage) { _ in
                    vm.loadImage()
                }
        }
    }
}

struct ChallengeImportImageView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeImportImageView()
    }
}
