//
//  MapProjectView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 30/01/2022.
//

import SwiftUI
import MapKit

struct MapProjectView: View {
    @StateObject private var vm = MapProjectViewModel()
    
    var body: some View {
        VStack {
            if vm.isUnlocked {
                ZStack {
                    Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                                
                                Text(location.name)
                                    .fixedSize()
                            }.onTapGesture {
                                vm.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()
                    
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button {
                                vm.addLocation()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }.sheet(item: $vm.selectedPlace) { place in
                    MapPlaceEditView(location: place) { vm.updateLocation(location: $0) }
                }
            } else {
                // show face id btn
                Button("Unlock places") {
                    vm.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }.alert(vm.errorMsg ?? "Error occur", isPresented: $vm.showError) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct MapProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MapProjectView()
    }
}

