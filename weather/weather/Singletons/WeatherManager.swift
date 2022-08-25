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
        switch period {
        case .day:
            return Array(repeating: Forecast(date: Date(), airHumidity: Array(55..<95).randomElement()!, temp: Array(1..<38).randomElement()!), count: 24)
        case .week:
            return Array(repeating: Forecast(date: Date(), airHumidity: Array(55..<95).randomElement()!, temp: Array(1..<38).randomElement()!), count: 7)
        case .month:
            return Array(repeating: Forecast(date: Date(), airHumidity: Array(55..<95).randomElement()!, temp: Array(1..<38).randomElement()!), count: 31)
        }
        
    }
    private init() {}
}
