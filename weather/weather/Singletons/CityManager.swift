//
//  CityManager.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//

import Foundation
import Firebase
import FirebaseFirestore


struct Feature: Codable {
    var center: [Double]
    var placeName: String
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case center
    }
}
enum Result {
    case success
    case error
}
struct FeatureCollection: Codable {
    let features: [Feature]
    let query: [String]
    enum CodingKeys: String, CodingKey {
        case features
        case query
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
    var output: CityManagerOutput? { get set }
    func loadCitySuggestions(_ citySearchRequest: String)
    func getApiKey(complition: @escaping (Result) -> ())
}

final class CityManager: CityManagerProtocol {
    func loadCitySuggestions(_ citySearchRequest: String) {
        let language = Locale.preferredLanguages[0].split(separator: "-").first
//        debugPrint("https://api.maptiler.com/geocoding/\(citySearchRequest).json?key=\(String(describing: apiKey!))&language=\(language)")
        let link = "https://api.maptiler.com/geocoding/\(citySearchRequest).json?key=\(String(describing: apiKey!))&language=\(language!)"
        debugPrint(link)
        if let urlString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    if let featureCollection = try? jsonDecoder.decode(FeatureCollection.self, from: data) {
                        let cities = featureCollection.features.compactMap { feature in
                            City(name: feature.placeName, center: (feature.center[0], feature.center[1]))
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
    
    func getApiKey(complition: @escaping (Result) -> ()) {
        let db = Firestore.firestore()

        let docRef = db.collection("APIs").document("maptiler")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let data = data,
                   let key = data["key"] as? String {
                    self.apiKey = key
                    complition(.success)
                } else {
                    complition(.error)
                }
            } else {
                complition(.error)
            }
        }
    }
    weak var output: CityManagerOutput?
    static let shared: CityManagerProtocol = CityManager()
    private init () { }
}
