//
//  ForecastProtocols.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import Foundation
import Charts

protocol ForecastModuleInput {
	var moduleOutput: ForecastModuleOutput? { get }
}

protocol ForecastModuleOutput: AnyObject {
}

protocol ForecastViewInput: AnyObject {
    func setDataForCell(for data: [BarChartDataEntry], to indexPath: IndexPath)
    func setHeaders(with forecasts: [Forecast])
}

protocol ForecastViewOutput: AnyObject {
    func viewDidLoad()
    func needDataForCell(at indexPath: IndexPath)
}

protocol ForecastInteractorInput: AnyObject {
    func viewDidLoad(for city: City)
    func needDataTempForExactDay(for date: Date, in city: City)
}

protocol ForecastInteractorOutput: AnyObject {
    func weatherDidLoaded(for weather: [Forecast], for period: Period)
}

protocol ForecastRouterInput: AnyObject {
}
