//
//  ImagePicker.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 19/01/2022.
//

import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    // SwiftUI will automatically call this method
    func makeCoordinator() -> Coordinator {
        // return a Coordinator instance
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // provide only images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    /**
     It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the photo picker can say things like “hey, the user selected an image, what do you want to do?”
     
     It makes the class conform to the PHPickerViewControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
     */
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // get inform which image user has selected from parent
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // close the picker
            picker.dismiss(animated: true)
            
            // Exit if no selection is selected
            guard let provider = results.first?.itemProvider else { return }
            
            // if has image
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    Task { @MainActor in
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
        
    }
    
}


