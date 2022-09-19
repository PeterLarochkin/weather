//
//  SearchPresenter.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//

import Foundation

final class SearchPresenter {
	weak var view: SearchViewInput?
    weak var moduleOutput: SearchModuleOutput?

	private let router: SearchRouterInput
	private let interactor: SearchInteractorInput

    init(router: SearchRouterInput, interactor: SearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchModuleInput {
}

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        interactor.setCachedCities()
    }
    
    func textFieldDidChange(with text: String) {
        interactor.textFieldDidChange(with: text)
    }
    
    func cellDidTapped(for city: City) {
        debugPrint("cellDidTapped")
        interactor.cityDidChosed(for: city)
    }

}

extension SearchPresenter: SearchInteractorOutput {
    func isTextFieldEmpty() -> Bool {
        guard let isEmpty = self.view?.isTextFieldEmpty() else {
            return true
        }
        return isEmpty
    }
    
    func setCities(for cities: [City]) {
        DispatchQueue.main.async {
            self.view?.setCitites(cities)
        }
    }
    
    
    func openCityModule(for city: City) {
        debugPrint("openCityModule")
        self.router.pushCityController(for: city)
    }
    
}
