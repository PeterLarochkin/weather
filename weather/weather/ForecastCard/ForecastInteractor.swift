//
//  ForecastInteractor.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import Foundation

final class ForecastInteractor {
	weak var output: ForecastInteractorOutput?
}

extension ForecastInteractor: ForecastInteractorInput {    
    func needDataTempForExactDay(for date: Date, in city: City) {
        debugPrint("needDataTempForExactDay")
        WeatherManager.shared.output = self
        WeatherManager.shared.loadWeatherForecast(city, .day, date)
    }
    
    func viewDidLoad(for city: City) {
        debugPrint("viewDidLoad")
        WeatherManager.shared.output = self
        WeatherManager.shared.loadWeatherForecast(city, .longTerm, Date())
    }
}
extension ForecastInteractor: WeatherManagerOutput {
    func weatherDidLoaded(for forecast: [Forecast], for period: Period) {
        debugPrint("weatherDidLoaded")
        output?.weatherDidLoaded(for: forecast, for: period)
    }
}
