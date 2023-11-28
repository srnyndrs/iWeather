//
//  ForecastData.swift
//  iWeather
//
//  Created by Suranyi on 07/11/2023.
//

import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [Forecast]?
    let city: City?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cod = try container.decodeIfPresent(String.self, forKey: .cod)
        self.message = try container.decodeIfPresent(Int.self, forKey: .message)
        self.cnt = try container.decodeIfPresent(Int.self, forKey: .cnt)
        self.list = try container.decodeIfPresent([Forecast].self, forKey: .list)
        self.city = try container.decodeIfPresent(City.self, forKey: .city)
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.coord = try container.decodeIfPresent(Coord.self, forKey: .coord)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.population = try container.decodeIfPresent(Int.self, forKey: .population)
        self.timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        self.sunrise = try container.decodeIfPresent(Int.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(Int.self, forKey: .sunset)
    }
}

// MARK: - List
struct Forecast: Codable, Identifiable {
    let id = UUID()
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dtTxt: String?
    let rain: Rain?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decodeIfPresent(Int.self, forKey: .dt)
        self.main = try container.decodeIfPresent(MainClass.self, forKey: .main)
        self.weather = try container.decodeIfPresent([Weather].self, forKey: .weather)
        self.clouds = try container.decodeIfPresent(Clouds.self, forKey: .clouds)
        self.wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
        self.visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        self.pop = try container.decodeIfPresent(Double.self, forKey: .pop)
        self.sys = try container.decodeIfPresent(Sys.self, forKey: .sys)
        self.dtTxt = try container.decodeIfPresent(String.self, forKey: .dtTxt)
        self.rain = try container.decodeIfPresent(Rain.self, forKey: .rain)
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decodeIfPresent(Double.self, forKey: .temp)
        self.feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike)
        self.tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
        self.tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
        self.pressure = try container.decodeIfPresent(Int.self, forKey: .pressure)
        self.seaLevel = try container.decodeIfPresent(Int.self, forKey: .seaLevel)
        self.grndLevel = try container.decodeIfPresent(Int.self, forKey: .grndLevel)
        self.humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
        self.tempKf = try container.decodeIfPresent(Double.self, forKey: .tempKf)
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
    let the3H: Double?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.the3H = try container.decodeIfPresent(Double.self, forKey: .the3H)
    }
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
