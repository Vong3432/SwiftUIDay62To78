//
//  PropertyWrapperLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 18/01/2022.
//

import SwiftUI

struct PropertyWrapperLearningView: View {
    @State private var blurAmount: CGFloat = 0.0 {
        didSet {
            // won't work for slider, bcz changes in binding will not trigger the setter
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount, perform: onSliderChange)
        }
    }
    
    private func onSliderChange(value: CGFloat) {
        print("New value is \(value)")
    }
}

struct PropertyWrapperLearningView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrapperLearningView()
    }
}
