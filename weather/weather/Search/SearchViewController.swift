//
//  ViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 20.07.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var cities : [City] = СacheManager.shared.historySearch
    
    let searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = .boldSystemFont(ofSize: Constants.heightOfSearchFont)
        searchTextField.isHidden = false
        searchTextField.backgroundColor = .white
        searchTextField.borderStyle = .roundedRect
        searchTextField.addTarget(self,
                                  action: #selector(searchTextFieldDidChange(_:)),
                                  for: .editingChanged)
        return searchTextField
    }()
    
    @objc
    private func searchTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            cities = Array(WeatherManager.shared.loadCitySuggestions(text)[..<text.count])
        } else {
            cities = СacheManager.shared.historySearch
        }
        suggestionTableView.reloadData()
    }
    
    lazy var suggestionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setLayout(){
        var constrants = [
            searchTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.searchTextFieldInsets.top),
            searchTextField.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: Constants.searchTextFieldInsets.left),
            searchTextField.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: Constants.searchTextFieldInsets.right),
            searchTextField.heightAnchor.constraint(
                equalToConstant: Constants.heightOfSearchTextField)
        ]
        constrants += [
            suggestionTableView.topAnchor.constraint(
                equalTo: searchTextField.bottomAnchor,
                constant: Constants.searchTextFieldInsets.top),
            suggestionTableView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: Constants.searchTextFieldInsets.left),
            suggestionTableView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor,
                constant: Constants.searchTextFieldInsets.right),
            suggestionTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constrants)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(suggestionTableView)
        suggestionTableView.rowHeight = UITableView.automaticDimension
        suggestionTableView.estimatedRowHeight = 44
        setLayout()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        cell.configureCell(cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Settings.shared.cityFontHeight + 8
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = CardController()
        vc.modalPresentationStyle = .fullScreen
        self.present(
            vc,
            animated: true,
            completion: nil)
    }
}

private extension SearchViewController {
    struct Constants {
        static let heightOfSearchFont: CGFloat = 48
        static let heightOfSearchTextField: CGFloat = 50
        static let searchTextFieldInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: -16, right: -16)
    }
}

