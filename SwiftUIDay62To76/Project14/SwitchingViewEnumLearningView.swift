//
//  SwitchingViewEnumLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 28/01/2022.
//

import SwiftUI

struct SwitchingViewEnumLearningView: View {
    private var loadingState = LoadingState.loading
    
    var body: some View {
        VStack {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchingViewEnumLearningView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewEnumLearningView()
    }
}
