//
//  WalletCell.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import UIKit
import Charts

final class CardCell: UICollectionViewCell {
    let emojiStates: [String] = ["🌤", "⛅", "🌦", "🌧", "⛈", "🌩", "☁️" , "☀️", "🌨", "🧣"]
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Settings.shared.dateFontHeight)
        label.textAlignment = .left
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Settings.shared.dateFontHeight)
        label.textAlignment = .right
        return label
    }()
    
    
    lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .systemGray6
        chartView.isHidden = false
        chartView.alpha = 1
        chartView.layer.cornerRadius = 10
        chartView.clipsToBounds = true
        return chartView
    }()
    
    func setData(_ data: [ChartDataEntry]){
        let chartData = LineChartData(
            dataSet: LineChartDataSet(
                entries: data,
                label: "Forecast"))
        chartView.data = chartData
    }
    
    func setLayout() {
        let constraints = [
            dateLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            dateLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            dateLabel.rightAnchor.constraint(
                equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(
                equalToConstant:
                    Settings.shared.dateFontHeight + 2 * Settings.shared.standartOffSets.top),
            
            tempLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            tempLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            tempLabel.leftAnchor.constraint(
                equalTo: dateLabel.rightAnchor),
            tempLabel.heightAnchor.constraint(
                equalTo: dateLabel.heightAnchor),
            
            chartView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.shortHeightOfCard),
            chartView.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            chartView.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            chartView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCell(_ forecast: Forecast,_ data: [ChartDataEntry]){
        self.dateLabel.text = (forecast.date.description)
        self.tempLabel.text = "\(forecast.temp)°C " + emojiStates.randomElement()!
        setData(data)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addViews()
        setLayout()
    }
    func addViews() {
        self.addSubview(dateLabel)
        self.addSubview(tempLabel)
        self.addSubview(chartView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardCell:ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}
