//
//  СacheManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation
protocol СacheManagerProtocol: AnyObject {
    func loadHistorySearchFromMemory()-> [City]
    func saveHistorySearchIntoMemory()->()
    var historySearch: [City] { get set }
}

final class СacheManager: СacheManagerProtocol {
    
    static let shared: СacheManagerProtocol = СacheManager()
    
    private init() {
        historySearch = loadHistorySearchFromMemory()
    }
    
    func loadHistorySearchFromMemory() -> [City] {
        let cities : [City] = [
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
            City(name: ["Novosibirsk", "Neryungri", "Smolenskoe"].randomElement()!,
                 lastWeather: ["⚡", "☀️", "🌧️"].randomElement()!),
        ]
        return cities
    }
    
    func saveHistorySearchIntoMemory() { }
    
    var historySearch: [City] = []
}
