//
//  SearchContainer.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//

import UIKit

final class SearchContainer {
    let input: SearchModuleInput
	let viewController: UIViewController
	private(set) weak var router: SearchRouterInput!

	class func assemble(with context: SearchContext) -> SearchContainer {
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(router: router, interactor: interactor)
		let viewController = SearchViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return SearchContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SearchModuleInput, router: SearchRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct SearchContext {
	weak var moduleOutput: SearchModuleOutput?
}
