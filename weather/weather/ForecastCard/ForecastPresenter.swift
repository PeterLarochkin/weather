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
        if let dateOfCell = mappingIndexDate?[indexPath.row], let city = city {
            interactor.needDataTempForExactDay(for: dateOfCell, in: city)
        }
    }
    
    func viewDidLoad() {
        if let city = self.city {
            interactor.viewDidLoad(for: city)
        }
    }
}

extension ForecastPresenter: ForecastInteractorOutput {
    func weatherDidLoaded(for weather: [Forecast], for period: Period) {
        switch period {
        case .day:
            view?.setDataForCell(for: [BarChartDataEntry](), to: IndexPath())
        case .month:
            mappingIndexDate = weather.map { $0.date }
        }
    }
    
}
