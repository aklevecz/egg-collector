//
//  SwiftUIView.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/6/24.
//

import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .regular))
            .padding(.vertical, 5)
    }
}

struct EggShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.07)) // Moved starting point down slightly
        
        // Top right curve (made more rounded)
        path.addCurve(
            to: CGPoint(x: width * 0.95, y: height * 0.65),
            control1: CGPoint(x: width * 0.85, y: height * 0.15), // Adjusted this point
            control2: CGPoint(x: width * 0.95, y: height * 0.45)  // And this one
        )
        
        // Bottom right curve
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.95),
            control1: CGPoint(x: width * 0.95, y: height * 0.85),
            control2: CGPoint(x: width * 0.75, y: height * 0.95)
        )
        
        // Bottom left curve
        path.addCurve(
            to: CGPoint(x: width * 0.05, y: height * 0.65),
            control1: CGPoint(x: width * 0.25, y: height * 0.95),
            control2: CGPoint(x: width * 0.05, y: height * 0.85)
        )
        
        // Top left curve (made more rounded)
        path.addCurve(
            to: CGPoint(x: width * 0.5, y: height * 0.07), // Matches the starting point
            control1: CGPoint(x: width * 0.05, y: height * 0.45), // Adjusted this point
            control2: CGPoint(x: width * 0.15, y: height * 0.15)  // And this one
        )
        
        return path
    }
}

struct EggsView: View {
    @Environment(ModelData.self) var modelData

    func find() {
        modelData.collection[0].isFound = true
    }
    
    var body: some View {
        VStack{
            Text("Eggs").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            List {
                ForEach(modelData.collection) { egg in
                    HStack(spacing: 16) {
                        EggShape()
                            .fill(egg.isFound ? Color.white : Color.clear)
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 24, height: 30)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(egg.name).modifier(CustomTextStyle())
                            Text(egg.description).font(.system(size:16))
                        }
                    }
                }
                .listRowBackground(Color.gray)
                .listRowSeparator(.hidden)
            }
            .border(Color.white)
            .listStyle(PlainListStyle())
            .padding(20)
        }
        .background(Color.gray)
        .foregroundColor(.white)

        .onDisappear() {
            print("EggView disappearing")
        }
    }
}

#Preview {
    EggsView().environment(ModelData())
}
