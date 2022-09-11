//
//  ForecastPresenter.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import Foundation
import Charts

final class ForecastPresenter {
    weak var view: ForecastViewInput?
    weak var moduleOutput: ForecastModuleOutput?
    
    private let router: ForecastRouterInput
    private let interactor: ForecastInteractorInput
    
    
    private var mappingIndexDate: [Date]?
    
    var city: City?
    
    init(router: ForecastRouterInput, interactor: ForecastInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ForecastPresenter: ForecastModuleInput {
}

extension ForecastPresenter: ForecastViewOutput {
    
    func needDataForCell(at indexPath: IndexPath) {
        debugPrint("needDataForCell")
        if let dateOfCell = mappingIndexDate?[indexPath.row], let city = city {
            interactor.needDataTempForExactDay(for: dateOfCell, in: city)
        }
    }
    
    func viewDidLoad() {
        debugPrint("viewDidLoad")
        if let city = self.city {
            interactor.viewDidLoad(for: city)
        }
    }
}

extension ForecastPresenter: ForecastInteractorOutput {
    func weatherDidLoaded(for weather: [Forecast], for period: Period) {
        switch period {
        case .day:
            debugPrint("weatherDidLoadedDay")
            if  let firstDate = weather.first?.date,
                let indexDateElement = mappingIndexDate?.enumerated().filter({ element in
                    Calendar.current.isDate(firstDate, equalTo: element.element, toGranularity: .day) }).first {
                let data = Array(weather.enumerated()).map({ element in
                    BarChartDataEntry(x: Double(element.offset), y: Double(element.element.temp))
                })
                view?.setDataForCell(for: data, to: IndexPath(row: indexDateElement.offset, section: 0))
            }
            
        case .month:
            debugPrint("weatherDidLoadedMonth")
            mappingIndexDate = weather.map { $0.date }
            view?.setHeaders(with: weather)
        }
    }
    
}
