//
//  ForecastViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 17.08.2022.
//

import UIKit
import Charts

final class ForecastViewController: UIViewController {
    
    lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .systemGray6
        chartView.isHidden = false
        chartView.alpha = 1
        chartView.layer.cornerRadius = 10
        chartView.clipsToBounds = true
        return chartView
    }()
    
    let periodSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["День", "Неделя", "Месяц"])
        segmentedControl.selectedSegmentIndex = 2
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(buttonDecrease(_:)),
            for: .allTouchEvents)
        button.addTarget(
            self,
            action: #selector(buttonIncreaseOrRemain(_:)),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(
            self,
            action: #selector(buttonPressed(_:)),
            for: [.touchUpInside])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.isEnabled = true
        button.backgroundColor = .systemGray5
        button.setTitle("Графиком", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    @objc
    private func buttonDecrease(_ button: UIButton) {
        UIView.animate(withDuration: 0.07){
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc
    private func buttonIncreaseOrRemain(_ button: UIButton) {
        UIView.animate(withDuration: 0.07){
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    @objc
    private func buttonPressed(_ button: UIButton) {
        debugPrint("buttonPressed")
        UIView.animate(
            withDuration: 0.3,
            animations: {
                swap(&self.forecastTableView.alpha, &self.chartView.alpha)
            },
            completion:  { _ in
                self.forecastTableView.isHidden = !self.forecastTableView.isHidden
                self.chartView.isHidden = !self.chartView.isHidden
            }
        )
    }
    
    lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ForecastTableViewCell.self,
            forCellReuseIdentifier: "ForecastTableViewCell")
        tableView.isHidden = true
        tableView.alpha = 0
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
            chartView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor),
            chartView.leftAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                constant: 8),
            chartView.rightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                constant: -8),
            chartView.bottomAnchor.constraint(
                equalTo: changeButton.topAnchor,
                constant: -8)
        ]
        constraints += [
            changeButton.leftAnchor.constraint(
                equalTo: forecastTableView.leftAnchor),
            changeButton.rightAnchor.constraint(
                equalTo: forecastTableView.rightAnchor),
            changeButton.heightAnchor.constraint(
                equalTo: periodSegmentControl.heightAnchor,
                multiplier: 1.2)
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
                equalToConstant: Settings.shared.dateFontHeight + 16)
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
        view.addSubview(chartView)
        forecastTableView.isHidden = true
        titleLabel.text = "Hello"
        setLayout()
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        31
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

extension ForecastViewController: ChartViewDelegate {
    
}
