//
//  ForecastViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 17.08.2022.
//

import UIKit

final class ForecastViewController: UIViewController {
    
    let periodSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["День", "Неделя", "Месяц"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let changeButton: UIButton = {
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
    
    let titleLabel:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Settings.shared.cityFontHeight)
        label.textAlignment = .center
        return label
    }()
    
    func setLayout() {
        var constraints = [
            titleLabel.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 4),
            titleLabel.leftAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                constant: 8),
            titleLabel.rightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                constant: -8),
            titleLabel.heightAnchor.constraint(
                equalToConstant: Settings.shared.cityFontHeight + 8)
        ]
        constraints += [
            forecastTableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor),
            forecastTableView.leftAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                constant: 8),
            forecastTableView.rightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                constant: -8),
            forecastTableView.bottomAnchor.constraint(
                equalTo: changeButton.topAnchor,
                constant: -8)
        ]
        constraints += [
            changeButton.leftAnchor.constraint(
                equalTo: forecastTableView.leftAnchor),
            changeButton.rightAnchor.constraint(
                equalTo: forecastTableView.rightAnchor),
            changeButton.heightAnchor.constraint(
                equalToConstant: Settings.shared.cityFontHeight + 4)
        ]
        constraints += [
            periodSegmentControl.topAnchor.constraint(
                equalTo: changeButton.bottomAnchor, constant: 8),
            periodSegmentControl.leftAnchor.constraint(
                equalTo: forecastTableView.leftAnchor),
            periodSegmentControl.rightAnchor.constraint(
                equalTo: forecastTableView.rightAnchor),
            periodSegmentControl.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -8),
            periodSegmentControl.heightAnchor.constraint(
                equalToConstant: Settings.shared.cityFontHeight + 4)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(forecastTableView)
        view.addSubview(titleLabel)
        view.addSubview(changeButton)
        view.addSubview(periodSegmentControl)
        titleLabel.text = "Hello"
        setLayout()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Settings.shared.cityFontHeight + 4
    }
}
