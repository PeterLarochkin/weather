//
//  WeatherManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation

protocol WeatherManagerProtocol {
    func loadCitySuggestions(_ citySearchRequest: String) -> [City]
}

class WeatherManager: WeatherManagerProtocol {
    
    static let shared: WeatherManager = WeatherManager()
    
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
    private init() {}
}
