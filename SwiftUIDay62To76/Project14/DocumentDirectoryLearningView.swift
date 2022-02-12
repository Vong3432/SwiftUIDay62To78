//
//  DocumentDirectoryLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 28/01/2022.
//

import SwiftUI

struct DocumentDirectoryLearningView: View {
    
    private var decodedContent: String = "Hello world"
    
    init() {
        //To fetch from Documents
        do {
            let storedStr = try FileManager.decode(String.self, from: "message.txt")
            print(storedStr)
            decodedContent = storedStr
        } catch {
            print("Err")
        }
    }
    
    var body: some View {
        Text(decodedContent)
            .onTapGesture {
                do {
                    try FileManager.encode("Hello encode", to: "message.txt")
                } catch {
                    print("Err")
                }
            }
    }
}

struct DocumentDirectoryLearningView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentDirectoryLearningView()
    }
}
