//
//  CityManager.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//

import Foundation

struct City {
    let name: String
    let lastWeather: String
}

protocol CityManagerOutput: AnyObject {
    func citySuggestionsDidLoaded(for cities: [City])
}

protocol CityManagerProtocol: AnyObject {
    var output: CityManagerOutput? { get set }
    func loadCitySuggestions(_ citySearchRequest: String)
}

final class CityManager: CityManagerProtocol {
    func loadCitySuggestions(_ citySearchRequest: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
            let sliceCount = cities.count - citySearchRequest.count < 0 ? 0 : cities.count - citySearchRequest.count
            self.output?.citySuggestionsDidLoaded(for: Array(cities[0..<sliceCount]))
        }
    }
    weak var output: CityManagerOutput?
    static let shared: CityManagerProtocol = CityManager()
    private init () { }
}
