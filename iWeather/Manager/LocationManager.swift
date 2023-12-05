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
    
    private var timeoutTimer: Timer?
    var locationObservers = [LocationObserver]()
    var latitude: Double = 47.4979
    var longitude: Double = 19.0402
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    override init() {
        super.init()
        locationManager.delegate = self
        timeoutTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(LocationManager.getLocation), userInfo: nil, repeats: true)
    }
    
    @objc func getLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                authorizationStatus = .authorizedWhenInUse
                getLocation()
                break
            case .restricted:
                authorizationStatus = .restricted
                break
            case .denied:
                authorizationStatus = .denied
            case .notDetermined:
                authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                break
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        if -location.timestamp.timeIntervalSinceNow > 5.0 {
            return
        }
        
        if location.horizontalAccuracy < 0 {
            return
        }
        
        let distanceInMeters = location.distance(from: CLLocation(latitude: self.latitude, longitude: self.longitude))

        if location.horizontalAccuracy >= manager.desiredAccuracy && distanceInMeters > 1000 {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            self.locationObservers.forEach { observer in
                observer.updateLocation(locationCoordinate)
            }
        }
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}

protocol LocationObserver : AnyObject {
    func updateLocation(_ coordinate: CLLocationCoordinate2D)
}
