//
//  GeocodingViewModel.swift
//  iWeather
//
//  Created by Suranyi on 23/11/2023.
//

import Foundation

class GeocodingViewModel: ObservableObject {
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
                }
            }
        } else {
            self.results = [LocationDataItem]()
        }
    }
    
    func resetSearch() {
        self.results = [LocationDataItem]()
    }
}
