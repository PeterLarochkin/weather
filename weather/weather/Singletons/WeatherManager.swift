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
    let emojiState: String
}

enum Period {
    case day
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
    
    let emojiStates: [String] = ["🌤", "⛅", "🌦", "🌧", "⛈", "🌩", "☁️" , "☀️", "🌨", "🧣"]
    
    func loadWeatherForecast(_ city: String, _ period: Period) -> [Forecast] {
        
        switch period {
        case .day:
            return Array(1...24).map { item in
                Forecast(
                    date: Date(),
                    airHumidity: Array(55..<95).randomElement()!,
                    temp: Array(1..<38).randomElement()!,
                    emojiState: emojiStates.randomElement()!)
            }
            
        case .month:
            return Array(1...30).map { item in
                Forecast(
                    date: Date(),
                    airHumidity: Array(55..<95).randomElement()!,
                    temp: Array(1..<38).randomElement()!,
                    emojiState: emojiStates.randomElement()!)
            }
        }
        
    }
    private init() {}
}
