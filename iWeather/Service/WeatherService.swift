//
//  WeatherService.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject, ObservableObject {
    // MARK - Location
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var userLocation : UserLocation {
        UserLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    var latitude: Double {
        locationManager.location?.coordinate.latitude ?? Constants.defaultLocation.latitude
    }
    
    var longitude: Double {
        locationManager.location?.coordinate.longitude ?? Constants.defaultLocation.longitude
    }
    
    // MARK - Weather
    private let API_KEY: String = "e74998255d559f5a0ac8fe4a4436a9a3"
    private var completionHandler: ((WeatherData) -> Void)?
    @Published var weatherData: WeatherData? = nil
    @Published var forecastData: ForecastData? = nil
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((WeatherData)-> Void)) async {
        if self.weatherData == nil {
            await populateWeatherData()
        }
        completionHandler(self.weatherData!)
    }
    
    public func loadForecastData(_ completionHandler: @escaping((ForecastData)-> Void)) async {
        if self.forecastData == nil {
            await populateForecastData()
        }
        completionHandler(self.forecastData!)
    }
    
    func populateWeatherData() async {
        let coords = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        do {
            let response = try await NetworkManager().get(url: URL(string: urlString)!) { data in
                return try? JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            self.weatherData = WeatherData(response: response)
        } catch {
            print(error)
        }
    }
    
    func populateForecastData() async {
        let coords = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coords.latitude)&lon=\(coords.longitude)&appid=\(API_KEY)&units=metric"
        do {
            let response = try await NetworkManager().get(url: URL(string: urlString)!) { data in
                return try? JSONDecoder().decode(ForecastResponse.self, from: data)
            }
            self.forecastData = ForecastData(response: response)
        } catch {
            print(error)
        }
    }
    
}

extension WeatherService : CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
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
    
}
