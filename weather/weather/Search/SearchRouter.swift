//
//  SearchRouter.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//

import UIKit

final class SearchRouter {
    weak var output: SearchRouterOutput?
}

extension SearchRouter: SearchRouterInput {
    func pushCityController(for city: City) {
        debugPrint("pushCityController")
        let container = ForecastContainer.assemble(with: ForecastContext(moduleOutput: nil))
        let vc = container.viewController // initial
        self.output?.pushCityController(for: vc)
    }
}
