//
//  PhotoRow.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import SwiftUI

struct PhotoRowView: View {
    
    let photo: PhotoModel
        
    var body: some View {
        HStack {
            PhotoView(name: photo.ref)
                .frame(width: 42, height: 42)
                .background(.gray.opacity(0.2))
                .clipShape(Circle())
            Text(photo.name)
        }
    }
    
    
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PhotoRowView(photo: PhotoModel(ref: "asd", name: "John Doe", latitude: 1.12, longitude: 0.12))
        }
        .previewLayout(.sizeThatFits)
    }
}
