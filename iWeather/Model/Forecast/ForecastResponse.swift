//
//  ForecastData.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

// MARK: - Welcome
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [Forecast]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct Forecast: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: System
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel: Int
    let grndLevel, humidity: Int?
    let tempKf: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.seaLevel = try container.decode(Int.self, forKey: .seaLevel)
        self.grndLevel = try container.decodeIfPresent(Int.self, forKey: .grndLevel)
        self.humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
        self.tempKf = try container.decode(Double.self, forKey: .tempKf)
    }

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct System: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}
