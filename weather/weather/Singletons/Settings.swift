//
//  Settings.swift
//  weather
//
//  Created by Петр Ларочкин on 02.08.2022.
//

import Foundation
import UIKit
class Settings {
    var cityFontHeight: CGFloat = 45
    var dateFontHeight: CGFloat = UIFont.preferredFont(forTextStyle: .largeTitle).xHeight
    var shortHeightOfCard: CGFloat = 50
    var longHeightOfCard: CGFloat = 250
    var standartOffSets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: -4, right: -4)
    
    static let shared: Settings = Settings()
    private init() {}
}

