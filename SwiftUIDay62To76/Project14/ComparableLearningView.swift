//
//  ComparableLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 28/01/2022.
//

import SwiftUI

struct ComparableLearningView: View {
    let users = [
        Project14User(firstName: "Arnold", lastName: "Rimmer"),
        Project14User(firstName: "Kristine", lastName: "Kochanski"),
        Project14User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct ComparableLearningView_Previews: PreviewProvider {
    static var previews: some View {
        ComparableLearningView()
    }
}
