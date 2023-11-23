//
//  GeocodingService.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import Foundation

public final class GeocodingService: NSObject, ObservableObject {
    private let API_KEY: String = "dfbdbf9247ca47fe8f22bb3f2f714faa"
    
    func populateLocations(query: String, _ completionHandler: @escaping((LocationData) -> Void)) async {
        //https://api.geoapify.com/v1/geocode/search?text=Berlin&lang=en&limit=10&type=city&format=json&apiKey=d548c5ed24604be6a9dd0d989631f783
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(query)&lang=en&limit=10&type=city&format=json&apiKey=\(API_KEY)"
        do {
            let response = try await NetworkManager().get(url: URL(string: urlString)!) { data in
                return try? JSONDecoder().decode(LocationResponse.self, from: data)
            }
            completionHandler(LocationData(response: response))
        } catch {
            print(error)
        }
    }
}
