//
//  ChallengeView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 06/02/2022.
//

import SwiftUI

struct ChallengeView: View {
    
    @StateObject private var vm = ChallengeViewModel()
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(vm.photos) { photo in
                    NavigationLink {
                        ChallengePhotoDetailView(photo: photo)
                    } label: {
                        PhotoRowView(photo: photo)
                    }
                }
            }   
            .toolbar {
                Button {
                    vm.showImportSheet = true
                } label: {
                    Text("Add")
                        .padding()
                }
            }
            .sheet(isPresented: $vm.showImportSheet) {
                ChallengeImportImageView()
            }
            .navigationTitle("List")
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
