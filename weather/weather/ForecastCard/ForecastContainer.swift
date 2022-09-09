//
//  ForecastContainer.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import UIKit

final class ForecastContainer {
    let input: ForecastModuleInput
	let viewController: UIViewController
	private(set) weak var router: ForecastRouterInput!

	class func assemble(with context: ForecastContext) -> ForecastContainer {
        let router = ForecastRouter()
        let interactor = ForecastInteractor()
        let presenter = ForecastPresenter(router: router, interactor: interactor)
		let viewController = ForecastViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ForecastContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ForecastModuleInput, router: ForecastRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ForecastContext {
	weak var moduleOutput: ForecastModuleOutput?
}
