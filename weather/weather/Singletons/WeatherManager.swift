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
    var apiKey: String? { get set }
    var output: WeatherManagerOutput? { get set }
    func loadWeatherForecast(_ city: City, _ period: Period, _ discoveredDay: Date) -> ()
}

struct ForecastRawMain: Codable {
    let temp: Float
    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Float
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

struct ForecastRawWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct ForecastRawWind: Codable {
    let speed: Float
    let deg: Int
    let gust: Float
}

struct ForecastRawClouds: Codable {
    let all: Int
}

struct ForecastRawRain: Codable {
    let threeH: Float
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct ForecastRaw : Codable {
    //    "dt": 1661871600,
    let main : ForecastRawMain
    let weather: [ForecastRawWeather]
    let clouds: ForecastRawClouds?
    let wind: ForecastRawWind?
    let visibility: Int?
    let pop: Float?
    let rain: ForecastRawRain?
    let dtTxt: String
    //    "2022-08-30 15:00:00"
    enum CodingKeys: String, CodingKey {
        case dtTxt = "dt_txt"
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case rain
    }
}

struct ForecastResponse: Codable {
    let cod: String
    let message: Int?
    let cnt: Int
    let list: [ForecastRaw]
}

struct Forecast {
    let date: Date
    let airHumidity: UInt
    let temp: Int
    let emojiState: String
}

enum Period {
    case day
    case longTerm
}

final class WeatherManager {
    //    var emojiStates: [String] = ["🌤", "⛅", "🌦", "🌧", "⛈", "🌩", "☁️" , "☀️", "🌨", "🧣"]
    var cachedQuery = [String : ForecastResponse]()
    weak var output: WeatherManagerOutput?
    var apiKey: String?
    static let shared: WeatherManagerProtocol = WeatherManager()
    private init() {}
}


extension WeatherManager: WeatherManagerProtocol {
    
    func prepareData(_ response:ForecastResponse,_ period: Period, _ discoveredTime: Date) -> [Forecast] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        print(response.list.isEmpty)
        if period == .day {
            let forecasts : [Forecast] = response.list.compactMap { raw in
                guard let date = dateFormatter.date(from: raw.dtTxt) else {
                    //                debugPrint(raw.dtTxt)
                    return nil
                }
                debugPrint(date)
                debugPrint(discoveredTime)
                
                if Calendar.current.compare(date, to: discoveredTime, toGranularity: .day) == .orderedSame {
                    let forecast = Forecast(date: date, airHumidity: UInt(raw.main.humidity), temp: Int(raw.main.temp), emojiState: "")
                    return forecast
                } else {
                    return nil
                }
            }
            return forecasts
        } else {
            
            let forecastsAll : [Forecast] = response.list.compactMap { raw in
                guard let date = dateFormatter.date(from: raw.dtTxt) else {
                    //                debugPrint(raw.dtTxt)
                    return nil
                }
   
                let forecast = Forecast(date: date, airHumidity: UInt(raw.main.humidity), temp: Int(raw.main.temp), emojiState: "")
                return forecast
   
            }
//            group by date
            let groupDict = Dictionary(grouping: forecastsAll) { (forecast) -> DateComponents in
                let date = Calendar.current.dateComponents([.day, .month, .year], from: forecast.date)
                return date
            }
            let forecasts: [ Forecast ] = groupDict.map { element in
                let key =  element.key
                let value = element.value
                let count = value.count
                let humidity = (value.map { Int($0.airHumidity) }.reduce(0, +)) / count
                let temp = (value.map { Int($0.temp) }.reduce(0, +)) / count
                
                var comps = DateComponents() // <1>
                comps.day = key.day
                comps.month = key.month
                comps.year = key.year

                let date = Calendar.current.date(from: comps)! // <2>
                
                return Forecast(date: date, airHumidity: UInt(humidity), temp: temp, emojiState: "")
            }
            return forecasts
        }
    }
    
    func loadWeatherForecast( _ city: City, _ period: Period, _ discoveredTime: Date) {
        let (lat, lon) = city.center
        let key = "\(lat)_\(lon)"
        
        
        guard let apiKey = apiKey else { return }
        if cachedQuery.keys.contains(key) {
            let response = cachedQuery[key]!
            let forecasts: [Forecast] = prepareData(response, period, discoveredTime)
                                        .sorted(by: {$0.date.compare($1.date) == .orderedAscending } )
            output?.weatherDidLoaded(for: forecasts, for: period)
            
        } else {
            let link = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
            debugPrint(link)
            if let urlString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        
                        let str = String(decoding: data, as: UTF8.self)
                        
                        do {
                            let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                            let forecasts: [Forecast] = self.prepareData(forecastResponse, period, discoveredTime)
                                                            .sorted(by: {$0.date.compare($1.date) == .orderedAscending } )
                            
                                                            
                            self.cachedQuery[key] = forecastResponse
                            self.output?.weatherDidLoaded(for: forecasts, for: period)
                            //                            debugPrint(forecastResponse)
                        } catch let err {
                            debugPrint(err)
                        }
                        
                    } else if let error = error {
                        print("HTTP Request Failed \(error)")
                    }
                }.resume()
            }
        }
        
    }
}
