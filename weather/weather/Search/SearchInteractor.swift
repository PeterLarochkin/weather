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
    func textFieldDidChange(with text: String) {
        if text.count == 0 {
            self.setCachedCities()
        } else {
            CityManager.shared.output = self
            CityManager.shared.loadCitySuggestions(text)
        }
    }
    
    func setCachedCities() {
        CacheManager.shared.output = self
        CacheManager.shared.loadHistorySearchFromMemory()
    }
    
    func cityDidChosed(for city: City) {
        debugPrint("cityDidChosed")
        self.output?.openCityModule(for: city)
    }
}

extension SearchInteractor: CacheManagerOutput {
    func citiesFromCacheDidLoad(for cities: [City]) {
        self.output?.setCities(for: cities)
    }
}

extension SearchInteractor: CityManagerOutput {
    func citySuggestionsDidLoaded(for cities: [City]) {
        self.output?.setCities(for: cities)
    }
}
