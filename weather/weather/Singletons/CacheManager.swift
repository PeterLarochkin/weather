//
//  СacheManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation

protocol CacheManagerOutput: AnyObject {
    func citiesFromCacheDidLoad(for cities: [City])
}
protocol СacheManagerProtocol: AnyObject {
    func loadHistorySearchFromMemory() -> ()
    func saveHistorySearchIntoMemory(_ cities: [City]) -> ()
    var output: CacheManagerOutput? { get set }
}

final class СacheManager: СacheManagerProtocol {
    
    static let shared: СacheManagerProtocol = СacheManager()
    weak var output: CacheManagerOutput?
    private init() { }
    
    func loadHistorySearchFromMemory() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)  {
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
            self.output?.citiesFromCacheDidLoad(for: cities)
        }
    }
    
    func saveHistorySearchIntoMemory(_ cities: [City]) { }
}
