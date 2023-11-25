//
//  ApiResponse.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

/*
struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: MainClass
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise, sunset: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.sunrise = try container.decodeIfPresent(Int.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(Int.self, forKey: .sunset)
    }
}

struct Weather: Codable {
    let id: Int
    let main: MainClass
    let description, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.deg = try container.decode(Int.self, forKey: .deg)
        self.gust = try container.decodeIfPresent(Double.self, forKey: .gust)
    }
}*/
// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coord = try container.decodeIfPresent(Coord.self, forKey: .coord)
        self.weather = try container.decodeIfPresent([Weather].self, forKey: .weather)
        self.base = try container.decodeIfPresent(String.self, forKey: .base)
        self.main = try container.decodeIfPresent(Main.self, forKey: .main)
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        self.wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
        self.clouds = try container.decodeIfPresent(Clouds.self, forKey: .clouds)
        self.dt = try container.decodeIfPresent(Int.self, forKey: .dt)
        self.sys = try container.decodeIfPresent(Sys.self, forKey: .sys)
        self.timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.cod = try container.decodeIfPresent(Int.self, forKey: .cod)
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.all = try container.decodeIfPresent(Int.self, forKey: .all)
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lon = try container.decodeIfPresent(Double.self, forKey: .lon)
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decodeIfPresent(Double.self, forKey: .temp)
        self.feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike)
        self.tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
        self.tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
        self.pressure = try container.decodeIfPresent(Int.self, forKey: .pressure)
        self.humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
    }

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.sunrise = try container.decodeIfPresent(Int.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(Int.self, forKey: .sunset)
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.main = try container.decodeIfPresent(String.self, forKey: .main)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decodeIfPresent(Double.self, forKey: .speed)
        self.deg = try container.decodeIfPresent(Int.self, forKey: .deg)
        self.gust = try container.decodeIfPresent(Double.self, forKey: .gust)
    }
}
