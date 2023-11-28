//
//  NetworkService.swift
//  iWeather
//
//  Created by Suranyi on 06/11/2023.
//

import Foundation

enum NetworkError : Error {
    case badRequest
    case decodingError
}

class NetworkManager {
    
    func get<T: Decodable>(url: URL, parse: (Data) -> T?) async throws -> T {
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkError.badRequest
        }
        
        guard let result = parse(data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
