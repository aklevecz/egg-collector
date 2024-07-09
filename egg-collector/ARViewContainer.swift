//
//  ARViewContainer.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/7/24.
//
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Environment(ModelData.self) var modelData
    @Binding var isInitialized: Bool
    @Binding var foundEgg: Egg?
    
    var isActive: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                print("Anchor found: \(anchor)")
                DispatchQueue.main.async {
                    self.parent.anchorFound(anchor)
                }
            }
        }
    }
    
    func configureImageTracking() -> ARWorldTrackingConfiguration {
        guard let imageTargets = ARReferenceImage.referenceImages(inGroupNamed: "image_targets", bundle: nil) else {
            fatalError("Cannot find image targets in image_targets")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = imageTargets
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }
    
    func makeUIView(context: Context) -> ARView {
        print("Making AR View")
        let arView = ARView(frame: .zero)
        let configuration = configureImageTracking()
        arView.session.run(configuration)
        
        arView.session.delegate = context.coordinator
        
        DispatchQueue.main.async {
            self.isInitialized = true
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if isActive {
            let configuration = configureImageTracking()
            uiView.session.run(configuration)
        } else {
            uiView.session.pause()
        }
    }
    
    func anchorFound(_ anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            let eggName = imageAnchor.referenceImage.name ?? "Unknown Egg"
            let newEgg = modelData.eggMap[eggName]
            do {
                foundEgg = newEgg
                try modelData.addEgg(egg: newEgg!)
            } catch {
                print("Did not add egg")
            }
        }
    }
}

////
////        // Create a cube model
//        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
//        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
//        let model = ModelEntity(mesh: mesh, materials: [material])
//        model.transform.translation.y = 0.05
//
//        // Create horizontal plane anchor for the content
//        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
//        anchor.children.append(model)
//
//        // Add the horizontal plane anchor to the scene
//        arView.scene.anchors.append(anchor)
