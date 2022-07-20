//
//  ViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 20.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let cities : [City] = [
        City(name: "Moscow"),
        City(name: "Moscow"),
        City(name: "Moscow"),
        City(name: "Moscow"),
        City(name: "Moscow"),
        City(name: "Moscow"),
        City(name: "Moscow")
    ]
    
    let searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = .boldSystemFont(ofSize: Constants.heightOfSearchFont)
        searchTextField.isHidden = false
        searchTextField.backgroundColor = .white
        searchTextField.borderStyle = .roundedRect
        return searchTextField
    }()
    
    lazy var tableViewOfSuggestions: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setLayout(){
        var constrants = [
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: Constants.searchTextFieldInsets.top),
            searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                  constant: Constants.searchTextFieldInsets.left),
            searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.searchTextFieldInsets.right),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.heightOfSearchTextField)
        ]
        constrants += [
            tableViewOfSuggestions.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constants.searchTextFieldInsets.top),
            tableViewOfSuggestions.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                  constant: Constants.searchTextFieldInsets.left),
            tableViewOfSuggestions.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.searchTextFieldInsets.right),
            tableViewOfSuggestions.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constrants)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(tableViewOfSuggestions)
        tableViewOfSuggestions.rowHeight = UITableView.automaticDimension
        tableViewOfSuggestions.estimatedRowHeight = 44
        setLayout()
        
    }

}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        return cell
    }
    
    
}

private extension MainViewController {
    struct Constants {
        static let heightOfSearchFont: CGFloat = 48
        static let heightOfSearchTextField: CGFloat = 50
        static let searchTextFieldInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: -16, right: -16)
        
    }
}

