//
//  SearchViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 05.09.2022.
//  
//


import UIKit

final class SearchViewController: UIViewController {
    
    var cities : [City] = []
    private let output: SearchViewOutput?

    init(output: SearchViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = .boldSystemFont(ofSize: Constants.heightOfSearchFont)
        searchTextField.isHidden = false
        searchTextField.borderStyle = .roundedRect
        searchTextField.isEnabled = false
        searchTextField.addTarget(self,
                                  action: #selector(searchTextFieldDidChange(_:)),
                                  for: .editingChanged)
        return searchTextField
    }()
    
    
    
    lazy var suggestionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setLayout(){
        let constrants = [
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
                equalToConstant: Constants.heightOfSearchTextField),
            
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
    
    @objc
    private func searchTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text{
            output?.textFieldDidChange(with: text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchTextField)
        view.addSubview(suggestionTableView)
        suggestionTableView.rowHeight = UITableView.automaticDimension
        suggestionTableView.estimatedRowHeight = 44
        setLayout()
        DispatchQueue.global().async { [weak output] in
            output?.viewDidLoad()
        }
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
        -1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        debugPrint("didSelectRowAt")
        self.output?.cellDidTapped(for: cities[indexPath.row])
    }
}

private extension SearchViewController {
    struct Constants {
        static let heightOfSearchFont: CGFloat = 40
        static let heightOfSearchTextField: CGFloat = 50
        static let searchTextFieldInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: -16, right: -16)
    }
}

extension SearchViewController: SearchViewInput {
    func unfreezeTextField() {
        self.searchTextField.isEnabled = true
        UIView.animate(withDuration: 0.5){
            self.searchTextField.backgroundColor = .systemGray6
        }
    }
    
    func freezeTextField() {
        self.searchTextField.isEnabled = false
    }

    func setCitites(_ cities: [City]) {
        self.cities = cities

        self.suggestionTableView.reloadData()
        
    }

}

extension SearchViewController: SearchRouterOutput {
    func pushCityController(for controller: UIViewController) {
        debugPrint("pushCityController")
        self.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
