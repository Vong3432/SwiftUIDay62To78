//
//  PickerLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 19/01/2022.
//

import SwiftUI

struct PickerLearningView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            /**
             However, nothing will happen when an image is selected, and the Cancel button won’t do anything either. You see, even though we’ve created and presented a valid PHPickerViewController, we haven’t actually told it how to respond to user interactions.

             To make that happens requires a wholly new concept: coordinators.
             */
            ImagePicker(image: $inputImage)
                .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    
    // will be call whenever ImagePicker is changing/picking images
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct PickerLearningView_Previews: PreviewProvider {
    static var previews: some View {
        PickerLearningView()
    }
}

