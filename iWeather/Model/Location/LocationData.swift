//
//  LocationData.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import Foundation

class LocationData {
    var results = [LocationDataItem]()
    
    init(response: LocationResponse) {
        if response.results != nil {
            for item in response.results! {
                self.results.append(LocationDataItem(response: item))
            }
        }
    }
}

class LocationDataItem {
    let latitude: Double
    let longitude: Double
    let city: String
    let address: String
    
    init(response: LocationResult) {
        self.latitude = response.lat ?? 0.0
        self.longitude = response.lon ?? 0.0
        self.address = response.formatted ?? "Unknown"
        self.city = response.city ?? "Unknown"
    }
}
