//
//  CombineImageLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 24/01/2022.
//
//  View that combine all previous lessons together

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct InstaFilterLearningView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterAngle = 90.0
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    private var disabledSaveBtn: Bool {
        image == nil ? true : false
    }
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFill()
                }.onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }.padding(.vertical)
                
                // radius filter slider
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius) { _ in
                                applyProcessing()
                            }
                    }
                }
                
                // angle filter slider
                if currentFilter.inputKeys.contains(kCIInputAngleKey) {
                    HStack {
                        Text("Angle")
                        Slider(value: $filterAngle, in: 0...100, step: 1)
                            .onChange(of: filterAngle) { _ in
                                applyProcessing()
                            }
                    }
                }
                
                HStack {
                    Button("Change filter", action: changeFilter)
                    Spacer()
                    Button("Save", action: save)
                        .disabled(disabledSaveBtn)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    VStack {
                        Text("Blur")
                        Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                        Button("Zoom Blur") { setFilter(CIFilter.zoomBlur()) }
                    }
                    VStack {
                        Text("Other")
                        Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                        Button("Edges") { setFilter(CIFilter.edges()) }
                        Button("Bloom") { setFilter(CIFilter.bloom()) }
                        Button("Motion blur") { setFilter(CIFilter.motionBlur()) }
                        Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                        Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                        Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                        Button("Vignette") { setFilter(CIFilter.vignette()) }
                    }
                    Button("Cancel", role: .cancel) { }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
    
    private func save() {
        guard let processedImage = processedImage else {
            return
        }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage)
        
        imageSaver.successHandler = {
            print("Sucess")
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
    }
    
    private func changeFilter() {
        showingFilterSheet = true
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        
        /**
         Core Image filters have a dedicated inputImage property that lets us send in a CIImage for the filter to work with, but often this is thoroughly broken and will cause your app to crash – it’s much safer to use the filter’s setValue() method with the key kCIInputImageKey.
         */
        
        // when users select image, grab that image and set it to the context
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        // then apply filter effects, and finally output it
        applyProcessing()
    }
    
    private func applyProcessing() {
        //        currentFilter.intensity = Float(filterIntensity)
        //        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) // will crash cause some filter dont have intensity
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputAmountKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputAmountKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        if inputKeys.contains(kCIInputBrightnessKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputBrightnessKey) }
        if inputKeys.contains(kCIInputAngleKey) { currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
        
    }
    
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct InstaFilterLearningView_Previews: PreviewProvider {
    static var previews: some View {
        InstaFilterLearningView()
    }
}
