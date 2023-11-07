//
//  UserLocation.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import Foundation
import SwiftUI
import MapKit

struct UserLocation {
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D
    var region: MKCoordinateRegion
    var cameraPosition: MapCameraPosition
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.region = MKCoordinateRegion(center: self.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.cameraPosition = .region(MKCoordinateRegion(center: self.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000))
    }
}
