//
//  WeatherManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation

protocol WeatherManagerProtocol {
    func loadCitySuggestions(_ citySearchRequest: String) -> [City]
    func loadWeatherForecast(_ city: String, _ period: Period) -> [Forecast]
}

struct Forecast {
    let date: Date
    let airHumidity: UInt
    let temp: Int
}

enum Period {
    case day
    case week
    case month
}

final class WeatherManager: WeatherManagerProtocol {
    
    static let shared: WeatherManagerProtocol = WeatherManager()
    
    func loadCitySuggestions(_ citySearchRequest: String) -> [City] {
        let cities : [City] = [
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: "Moscow", lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
        ]
        return cities
    }
    
    func loadWeatherForecast(_ city: String, _ period: Period) -> [Forecast] {
        return []
    }
    private init() {}
}
