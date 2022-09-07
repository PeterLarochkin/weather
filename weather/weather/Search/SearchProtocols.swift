//
//  SearchProtocols.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//

import Foundation
import UIKit

protocol SearchModuleInput {
	var moduleOutput: SearchModuleOutput? { get }
}

protocol SearchModuleOutput: AnyObject {
}

protocol SearchViewInput: AnyObject {
    func setCitites(_ cities: [City])
}

protocol SearchViewOutput: AnyObject {
    func textFieldDidChange(with text: String)
    func textFieldDidEmpty()
    func cellDidTapped(for city: City)
    func viewDidLoad()
    
}

protocol SearchInteractorInput: AnyObject {
    func cityDidChosed(for city: City)
    func suggestionViewDidLoaded()
}

protocol SearchInteractorOutput: AnyObject {
    func openCityModule(for city: City)
    func setCacheHistory(for cities: [City])
}

protocol SearchRouterInput: AnyObject {
    func pushCityController(for city: City)
    
}

protocol SearchRouterOutput: AnyObject {
    func pushCityController(for controller: UIViewController)
}
