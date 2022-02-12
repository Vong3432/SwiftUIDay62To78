//
//  ImageSaver.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 25/01/2022.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    /**
     Mark the method using a special compiler directive called #selector, which asks Swift to make sure the method name exists where we say it does.
     
     Add an attribute called @objc to the method, which tells Swift to generate code that can be read by Objective-C.
     */
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
