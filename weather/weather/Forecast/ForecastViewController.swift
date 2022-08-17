//
//  ForecastViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 17.08.2022.
//

import UIKit

final class ForecastViewController: UIViewController {
    
    var changeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeAppearence(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    @objc
    private func changeAppearence(_ button: UIButton) { }
    
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ForecastTableViewCell.self,
            forCellReuseIdentifier: "ForecastTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        cell.configureCell(Forecast(date: Date(), airHumidity: 97, temp: 32), for: .day)
        return cell
    }
}
