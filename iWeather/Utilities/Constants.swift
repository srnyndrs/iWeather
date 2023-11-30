//
//  Constants.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

struct Constants {
    class defaultLocation {
        static let latitude = 47.497913
        static let longitude = 19.040236
        static let coordination = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //static let API_KEY: String = "e74998255d559f5a0ac8fe4a4436a9a3"
    
    static let MockUserLocation = UserLocation(
        latitude: 47.497913,
        longitude: 19.040236
    )
    
    static let MockUserRegion = Constants.MockUserLocation.cameraPosition
    
    static let defaultIcon = "❓"
    static let iconMap = [
        "Drizzle" : "🌧️",
        "Thunderstorm" : "⛈️",
        "Rain" : "🌧️",
        "Snow" : "❄️",
        "Clear" : "☀️",
        "Clouds" : "☁️",
        "Mist" : "🌫️",
        "Default": "❓"
    ]
}
