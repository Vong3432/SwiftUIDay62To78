//
//  ChallengePhotoDetailView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import SwiftUI
import MapKit

struct ChallengePhotoDetailView: View {
    let photo: PhotoModel
    @State private var region: MKCoordinateRegion
    @State private var marker: Location
    
    private let linearGradent = LinearGradient(
        gradient: Gradient(stops: [
            Gradient.Stop(color: .black.opacity(0.1), location: 0),
            Gradient.Stop(color: .black.opacity(1), location: 1.2),
        ]),
        startPoint: .top,
        endPoint: .bottom)
    
    init(photo: PhotoModel) {
        self.photo = photo
        _region = State(initialValue: MKCoordinateRegion(center: photo.coordinate, latitudinalMeters: 720, longitudinalMeters: 720))
        _marker = State(initialValue: Location(name: "Place", coordinate: photo.coordinate))
    }
    
    var body: some View {
        ZStack {
            PhotoView(name: photo.ref)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                Text("John Doe")
                    .font(.title)
                
                Map(coordinateRegion: $region, annotationItems: [marker]) { marker in
                    MapMarker(coordinate: marker.coordinate)
                }.frame(height: 300)
                    .cornerRadius(12.0)
            }
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: UIScreen.main.bounds.width ,alignment: .leading)
            .padding()
            .background(linearGradent)
        }
    }
}

struct ChallengePhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengePhotoDetailView(photo: PhotoModel(ref: "asd", name: "John Doe", latitude: 1.12,longitude: 0.12))
    }
}
