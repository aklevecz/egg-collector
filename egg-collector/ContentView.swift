//
//  ContentView.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/6/24.
//

import SwiftUI
import RealityKit

let customGrayColor = Color(red: 0.75, green: 0.75, blue: 0.75)

struct ColorSchemeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .background(colorScheme == .light ? Color.gray : Color.gray)
//            .border(colorScheme == .light ? Color.red : Color.white)
            .foregroundColor(colorScheme == .light ? Color.white : Color.white)
    }
}

struct ContentView : View {
    @Environment(ModelData.self) var modelData
    @Environment(\.scenePhase) private var scenePhase
    @State private var activeEggID: String?
    @State private var shouldNavigateToEggDetail: Bool = false
    
//    let nfcReader = NFCReader()

    var body: some View {
        NavigationStack {
            ZStack {
                ARViewer()
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: EggsView()) {
                            Text("Eggs")
                                .padding()
                        }
                        .padding()
                    }
//                    Button("Scan NFC Tag") {
//                      nfcReader.beginScanning()
//                    }
                    Spacer()
                }
            }.navigationDestination(isPresented: Binding(
                get: { activeEggID != nil },
                set: { if !$0 { activeEggID = nil } }
            )) {
                if let eggID = activeEggID {
                    EggDetailView(eggID: eggID)
                }
            }
        }
        .onOpenURL(perform: { url in
            handleIncomingURL(url)
        })
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                print("App became active")
            case .inactive:
                print("App became inactive")
                Task {
                    do {
                        print("SAVING DATA TO FILE")
                        try await modelData.save()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            case .background:
                print("App entered background")
            @unknown default:
                print("Unknown scene phase")
            }
        }
    }
    
    private func handleIncomingURL(_ url: URL) {
         guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
               let host = components.host else {
             print("Invalid URL")
             return
         }
        print(url)
         switch host {
         case "egg":
             if let idItem = components.queryItems?.first(where: { $0.name == "id" }),
                let id = idItem.value {
                 print("Egg scanned: \(id)")
                 activeEggID = id
                 shouldNavigateToEggDetail = true
//                 appState.lastScannedEggID = id
                 
             }
         default:
             print("Unknown URL scheme")
         }
     }
}



#Preview {
    ContentView().environment(ModelData())
}
