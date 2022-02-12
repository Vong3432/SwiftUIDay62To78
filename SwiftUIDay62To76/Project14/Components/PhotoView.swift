//
//  PhotoView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import SwiftUI

struct PhotoView: View {
    @State private var image: Image?
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFill()
            }
        }.onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        do {
            let imgData = try FileManager.decode(Data.self, from: name)
            guard let uiimage = UIImage(data: imgData) else { return }
            
            self.image = Image(uiImage: uiimage)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(name: "asd")
    }
}
