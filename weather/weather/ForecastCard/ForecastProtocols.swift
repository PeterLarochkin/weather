//
//  ForecastProtocols.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import Foundation

protocol ForecastModuleInput {
	var moduleOutput: ForecastModuleOutput? { get }
}

protocol ForecastModuleOutput: AnyObject {
}

protocol ForecastViewInput: AnyObject {
}

protocol ForecastViewOutput: AnyObject {
}

protocol ForecastInteractorInput: AnyObject {
}

protocol ForecastInteractorOutput: AnyObject {
}

protocol ForecastRouterInput: AnyObject {
}
