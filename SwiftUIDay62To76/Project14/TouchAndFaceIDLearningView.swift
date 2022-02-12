//
//  TouchAndFaceIDLearningView.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 29/01/2022.
//

import SwiftUI
import LocalAuthentication

struct TouchAndFaceIDLearningView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }.onAppear(perform: authenticate)
    }
    
    private func authenticate() {
        // query biometric status and perform auth check
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    isUnlocked = true
                } else {
                    print("err: \(String(describing: authError?.localizedDescription))")
                }
            }
        } else {
            // no biometrics
            if let error = error {
                print("err: \(error.localizedDescription)")
            }
        }
    }
}

struct TouchAndFaceIDLearningView_Previews: PreviewProvider {
    static var previews: some View {
        TouchAndFaceIDLearningView()
    }
}
