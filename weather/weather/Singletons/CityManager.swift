//
//  CityManager.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//

import Foundation
import Firebase

enum Result {
    case success
    case error
}





struct Feature: Codable {
    let name: String
    let localNames: [String : String]?
    let lat : Double
    let lon: Double
    let country: String?
    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case name, lat, lon, country
    }
}

struct City {
    let name: String
    let center: (Double, Double)
}

protocol CityManagerOutput: AnyObject {
    func citySuggestionsDidLoaded(for cities: [City])
}

protocol CityManagerProtocol: AnyObject {
    var apiKey: String? { get set }
    var output: CityManagerOutput? { get set }
    func loadCitySuggestions(_ citySearchRequest: String)
}

final class CityManager: CityManagerProtocol {
    func loadCitySuggestions(_ citySearchRequest: String) {
        guard let language = Locale.preferredLanguages[0].split(separator: "-").first else {
            return
        }

        let link = "https://api.openweathermap.org/geo/1.0/direct?q=\(citySearchRequest)&limit=5&appid=\(String(describing: apiKey!))"
        debugPrint(link)
        if let urlString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    debugPrint(String(data: data, encoding: .utf8))
                    let jsonDecoder = JSONDecoder()
                    if let featureCollection = try? jsonDecoder.decode([Feature].self, from: data) {
                        
                        let cities = featureCollection.compactMap { feature in
                            let name = feature.localNames?[String(language)] ?? feature.name
                            return City(name: name, center: (feature.lat, feature.lon))
                        }
                        self.output?.citySuggestionsDidLoaded(for: cities)
                    }
                    
                    
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }
    }
    
    var apiKey: String?
    

    weak var output: CityManagerOutput?
    static let shared: CityManagerProtocol = CityManager()
    private init () { }
}
