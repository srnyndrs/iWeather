//
//  GeocodingViewModel.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import Foundation

class GeocodingViewModel: ObservableObject {
    private let API_KEY: String = "dfbdbf9247ca47fe8f22bb3f2f714faa"
    let geocodingService: GeocodingService
    @Published var results = [LocationDataItem]()
    @Published var searchText: String = ""
    
    init(geocodingService: GeocodingService) {
        self.geocodingService = geocodingService
    }
    
    func searchForLocation() async {
        if !searchText.isEmpty {
            await geocodingService.populateLocations(query: searchText) { locationData in
                DispatchQueue.main.async {
                    self.results = locationData.results
                    print(self.results)
                }
            }
        } else {
            self.results = [LocationDataItem]()
        }
    }
    
    func resetSearch() {
        self.results = [LocationDataItem]()
    }
    
    /*func fetchData() {
        if !searchText.isEmpty {
            print("Fetch data")
            let urlString = "https://api.geoapify.com/v1/geocode/search?text=\(searchText)&lang=en&limit=10&type=city&format=json&apiKey=\(API_KEY)"
            if let url = URL(string: urlString) {
                let session: URLSession = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil{
                        let decoder = JSONDecoder()
                        if let safeData = data{
                            do{
                                let response = try decoder.decode(LocationResponse.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.results = LocationData(response: response).results
                                    print(self.results.first?.address ?? "hey")
                                }
                            } catch{
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
            }
        } else {
            self.results = [LocationDataItem]()
        }
    }*/
}
