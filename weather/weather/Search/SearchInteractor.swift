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
            self.viewDidLoad()
        } else {
            CityManager.shared.output = self
            CityManager.shared.loadCitySuggestions(text)
        }
    }
    
    func viewDidLoad() {
        CacheManager.shared.output = self
        CacheManager.shared.loadHistorySearchFromMemory()
        Settings.shared.getApiKeys{ [weak output] result in
            switch result {
            case .success:
                output?.unfreezeTextField()
            case .error:
                debugPrint("error")
            }
        }
    }
    
    func cityDidSelect(for city: City) {
        debugPrint("cityDidSelect")
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
//        guard let isTextFieldEmpty = self.output?.isTextFieldEmpty() else {
//            self.setCachedCities()
//            return
//        }
//        if isTextFieldEmpty {
//            self.setCachedCities()
//        } else {
            self.output?.setCities(for: cities)
//        }
    }
}
