//
//  GeocodingService.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import Foundation

public final class GeocodingService: NSObject, ObservableObject {
    private let API_KEY: String = "dfbdbf9247ca47fe8f22bb3f2f714faa"
    
    func fetchLocations(query: String, _ completionHandler: @escaping((LocationData) -> Void)) {
        let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(query)&lang=en&limit=10&type=city&format=json&apiKey=\(API_KEY)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
                        do {
                            let response = try decoder.decode(LocationResponse.self, from: data)
                            completionHandler(LocationData(response: response))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
