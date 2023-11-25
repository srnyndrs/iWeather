//
//  LocationManager.swift
//  iWeather
//
//  Created by Suranyi on 04/11/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var locationCoordinate: CLLocationCoordinate2D {
        locationManager.location?.coordinate ?? Constants.defaultLocation.coordination
    }
    
    var userLocation : UserLocation {
        UserLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    var latitude: Double {
        locationManager.location?.coordinate.latitude ?? Constants.defaultLocation.latitude
    }
    
    var longitude: Double {
        locationManager.location?.coordinate.longitude ?? Constants.defaultLocation.longitude
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                authorizationStatus = .authorizedWhenInUse
                locationManager.requestLocation()
                break
            case .restricted:
                authorizationStatus = .restricted
                break
            case .denied:
                authorizationStatus = .denied
            case .notDetermined:
                authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                print("asked")
                break
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}
