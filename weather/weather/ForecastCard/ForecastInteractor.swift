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
}
