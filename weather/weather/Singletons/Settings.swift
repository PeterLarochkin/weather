//
//  Settings.swift
//  weather
//
//  Created by Петр Ларочкин on 02.08.2022.
//

import Foundation
import UIKit
class Settings {
    var cityFontHeight: CGFloat = 24
    var dateFontHeight: CGFloat = 18
    var shortHeightOfCard: CGFloat = 50
    var longHeightOfCard: CGFloat = 250
    var standartOffSets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
    
    static let shared: Settings = Settings()
    private init() {}
}

