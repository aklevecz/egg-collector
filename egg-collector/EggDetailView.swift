//
//  EggDetailView.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/8/24.
//

import SwiftUI

struct EggDetailView: View {
    let eggID: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("You found").font(.system(size:40, weight: .black))
            Text("Egg").font(.system(size:30, weight: .black))
            Text("\(eggID)")
                .font(.system(size: 50, weight: .black))
                .foregroundColor(.white)
                .frame(width: 200, height: 200) // Smaller frame for the text
                .background(
                    Circle()
                        .fill(Color.black)
                        .frame(width: 200, height: 200) // Larger frame for the circle
                )
                .padding(30)
        }
    }
}

#Preview {
    EggDetailView(eggID: "DOG")
}
