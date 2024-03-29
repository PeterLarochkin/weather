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
    func unfreezeTextField()
    func freezeTextField()
}

protocol SearchViewOutput: AnyObject {
    func textFieldDidChange(with text: String)
    func cellDidTapped(for city: City)
    func viewDidLoad()
}

protocol SearchInteractorInput: AnyObject {
    func cityDidSelect(for city: City)
    func viewDidLoad()
    func textFieldDidChange(with text: String)
}

protocol SearchInteractorOutput: AnyObject {
    func openCityModule(for city: City)
    func setCities(for cities: [City])
    func unfreezeTextField()
    func freezeTextField()
}

protocol SearchRouterInput: AnyObject {
    var output: SearchRouterOutput? { get set }
    func pushCityController(for city: City)
    
}

protocol SearchRouterOutput: AnyObject {
    func pushCityController(for controller: UIViewController)
}
