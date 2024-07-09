//
//  ARView.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/7/24.
//

import SwiftUI

struct ARViewer: View {
    @State private var isARInitialized = false
    @State private var isARViewPresent = true
    @State private var foundEgg: Egg?

    var body: some View {
        ZStack {
            ARViewContainer(isInitialized: $isARInitialized,  foundEgg: $foundEgg, isActive: isARViewPresent)
                .edgesIgnoringSafeArea(.all)
            if !isARInitialized {
                ProgressView("Initializing AR...")
            }
            
            VStack {
                Spacer()
                Text(foundEgg?.name ?? "Waiting for egg")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            isARViewPresent = true
            isARInitialized = true
        }
        .onDisappear {
            isARViewPresent = false
            print("ARView disappearing")
        }
        
    
    }
}
//#Preview {
//    ARViewer()
//}
