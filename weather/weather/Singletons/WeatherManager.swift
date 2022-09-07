//
//  WeatherManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation

protocol WeatherManagerOutput: AnyObject {
    
    func weatherDidLoaded(for forecast: [Forecast])
}




protocol WeatherManagerProtocol {
    var output: WeatherManagerOutput? { get set }
    func loadWeatherForecast(_ city: String, _ period: Period, _ discoveredDay: Date, _ completion: (_ cities: [Forecast]) -> ())
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

final class WeatherManager {
    let emojiStates: [String] = ["🌤", "⛅", "🌦", "🌧", "⛈", "🌩", "☁️" , "☀️", "🌨", "🧣"]
    weak var output: WeatherManagerOutput?
    static let shared: WeatherManagerProtocol = WeatherManager()
    private init() {}
}

extension WeatherManager: WeatherManagerProtocol {
    func loadWeatherForecast(
            _ city: String,
            _ period: Period,
            _ discoveredTime: Date,
            _ completion: ([Forecast]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            switch period {
            case .day:
                let forecasts = Array(1...24).map { item in
                    Forecast(
                        date: Date(),
                        airHumidity: Array(55..<95).randomElement()!,
                        temp: Array(1..<38).randomElement()!,
                        emojiState: self.emojiStates.randomElement()!)
                }
                
                self.output?.weatherDidLoaded(for: forecasts)
            case .month:
                let forecasts = Array(1...30).map { item in
                    Forecast(
                        date: Date(),
                        airHumidity: Array(55..<95).randomElement()!,
                        temp: Array(1..<38).randomElement()!,
                        emojiState: self.emojiStates.randomElement()!)
                }
                self.output?.weatherDidLoaded(for: forecasts)
            }
        }
    }
}
