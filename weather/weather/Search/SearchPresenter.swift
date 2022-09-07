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
        interactor.suggestionViewDidLoaded()
    }
    
    func textFieldDidEmpty() {
        
    }
    
    func textFieldDidChange(with text: String) {
        
    }
    
    func cellDidTapped(for city: City) {
        interactor.cityDidChosed(for: city)
    }

}

extension SearchPresenter: SearchInteractorOutput {
    func setCacheHistory(for cities: [City]) {
        self.view?.setCitites(cities)
    }
    
    
    func openCityModule(for city: City) {
        self.router.pushCityController(for: city)
    }
    
}
