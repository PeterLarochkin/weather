//
//  ForecastPresenter.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import Foundation

final class ForecastPresenter {
	weak var view: ForecastViewInput?
    weak var moduleOutput: ForecastModuleOutput?

	private let router: ForecastRouterInput
	private let interactor: ForecastInteractorInput

    init(router: ForecastRouterInput, interactor: ForecastInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ForecastPresenter: ForecastModuleInput {
}

extension ForecastPresenter: ForecastViewOutput {
}

extension ForecastPresenter: ForecastInteractorOutput {
}
