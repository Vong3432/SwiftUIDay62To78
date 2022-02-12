//
//  LoadingView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 28/01/2022.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingView()
            SuccessView()
            FailedView()
        }.previewLayout(.sizeThatFits)
    }
}
