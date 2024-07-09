//
//  Egg.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/6/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct Egg: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var isFound: Bool
//    private var imageName: String
//    var image: Image {
//        Image(imageName)
//    }
//
//    private var coordinates: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }
//
//    struct Coordinates: Hashable, Codable {
//        var latitude: Double
//        var longitude: Double
//    }
}
