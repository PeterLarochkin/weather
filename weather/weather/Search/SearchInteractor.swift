//
//  SearchInteractor.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//

import Foundation

final class SearchInteractor {
    
    
	weak var output: SearchInteractorOutput?
}

extension SearchInteractor: SearchInteractorInput {
    func suggestionViewDidLoaded() {
        СacheManager.shared.output = self
        СacheManager.shared.loadHistorySearchFromMemory()
    }
    
    func cityDidChosed(for city: City) {
        debugPrint("cityDidChosed")
        self.output?.openCityModule(for: city)
    }
}
extension SearchInteractor: CacheManagerOutput {
    func citiesFromCacheDidLoad(for cities: [City]) {
        output?.setCacheHistory(for: cities)
    }
}
