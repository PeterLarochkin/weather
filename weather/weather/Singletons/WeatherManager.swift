//
//  WeatherManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation

protocol WeatherManagerOutput: AnyObject {
    func weatherDidLoaded(for forecast: [Forecast], for period: Period)
}

protocol WeatherManagerProtocol: AnyObject {
    var output: WeatherManagerOutput? { get set }
    func loadWeatherForecast(_ city: City, _ period: Period, _ discoveredDay: Date) -> ()
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
    func loadWeatherForecast( _ city: City, _ period: Period, _ discoveredTime: Date) {
        
        
        guard let discoveredTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: discoveredTime) else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            let len = { () -> Int in
                switch period {
                case .day:
                    debugPrint("loadWeatherForecastDay")
                    return 24
                case .month:
                    debugPrint("loadWeatherForecastMonth")
                    return 31
                }
            }()
            
            let forecasts = Array(1...len).compactMap { item -> Forecast? in
                guard let date = Calendar.current.date(byAdding: .hour, value: item, to: discoveredTime) else {
                    return nil
                }
                return Forecast(
                    date: date,
                    airHumidity: Array(55..<95).randomElement()!,
                    temp: Array(1..<38).randomElement()!,
                    emojiState: self.emojiStates.randomElement()!)
            }
            self.output?.weatherDidLoaded(for: forecasts, for: period)
        }
    }
}
