//
//  CoreImageLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 19/01/2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageLearningView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        
        /**
         We can create a UIImage from a CGImage, and create a CGImage from a UIImage.
         We can create a CIImage from a UIImage and from a CGImage, and can create a CGImage from a CIImage.
         We can create a SwiftUI Image from both a UIImage and a CGImage.
         */
        
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        // sepia filter
        //            let currentFilter = CIFilter.sepiaTone()
        //            currentFilter.inputImage = beginImage
        //            currentFilter.intensity = 1
        
        // pixelize filter
        //        let currentFilter = CIFilter.pixellate()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.scale = 100
        
        // crystallize filter
        //        let currentFilter = CIFilter.crystallize()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.radius = 200
        
        // twirl filter
        //        let currentFilter = CIFilter.twirlDistortion()
        //        currentFilter.inputImage = beginImage
        //        currentFilter.radius = 1000
        //        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
        
        let amount = 1.0
        
        // use this so that whenever currentFilter changed, only the API that currentFilter support will execute the setValue below.
        // eg: If currentFilter = twirlDistortion, and it supports only "intensity", then the "radius" and "scale" at below will not be executed.
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        // get CIImage
        guard let outputImage = currentFilter.outputImage else { return }
        
        // get CGImage from CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            
            // get UIImage from CGImage
            let uiImage = UIImage(cgImage: cgimg)
            
            // get Swift image from UIImage
            image = Image(uiImage: uiImage)
        }
        
    }
}

struct CoreImageLearningView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageLearningView()
    }
}
