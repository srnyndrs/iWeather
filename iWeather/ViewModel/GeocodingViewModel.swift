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
    
    func searchLocation() {
        if !searchText.isEmpty {
            geocodingService.fetchLocations(query: searchText) { locationData in
                DispatchQueue.main.async {
                    self.results = locationData.results
                }
            }
        } else {
            self.results = [LocationDataItem]()
        }
    }
    
    func resetSearch() {
        self.searchText = ""
        self.results = [LocationDataItem]()
    }
}
