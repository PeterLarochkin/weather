//
//  Settings.swift
//  weather
//
//  Created by Петр Ларочкин on 02.08.2022.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol SettingsProtocol: AnyObject {
    func getApiKeys (completion: @escaping (Result) -> ()) -> ()
    var cityFontHeight: CGFloat { get set }
    var dateFontHeight: CGFloat { get set }
    var shortHeightOfCard: CGFloat { get set }
    var longHeightOfCard: CGFloat { get set }
    var standartOffSets: UIEdgeInsets { get set }
}

class Settings {
    var cityFontHeight: CGFloat = 24
    var dateFontHeight: CGFloat = 18
    var shortHeightOfCard: CGFloat = 50
    var longHeightOfCard: CGFloat = 250
    var standartOffSets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
    
    static let shared: SettingsProtocol = Settings()
    private init() {}
    
}

extension Settings: SettingsProtocol {
    func getApiKeys (completion: @escaping (Result) -> ()) {
        let db = Firestore.firestore()
        
        let docRef = db.collection("APIs").document("APIKeys")
        docRef.getDocument(source: .server) { (document, error) in
            if let document = document,
               let data = document.data() {
                CityManager.shared.apiKey = data["maptiler"] as? String
                WeatherManager.shared.apiKey = data["opeweathermap"] as? String
                completion(.success)
            } else {
                completion(.error)
            }
        }        
    }
}

