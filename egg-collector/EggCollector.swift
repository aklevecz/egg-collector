import SwiftUI

@main
struct EggCollector: App {
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(modelData)
        }
    }
}
