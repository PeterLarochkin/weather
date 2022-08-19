//
//  Settings.swift
//  weather
//
//  Created by Петр Ларочкин on 02.08.2022.
//

import Foundation
import UIKit
class Settings{
    var cityFontHeight: CGFloat = 45
    var dateFontHeight: CGFloat = 18
    private init() {}
    static let shared: Settings = Settings()
}

