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
    
    func setLayout() {
        let constraints = [
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            dateLabel.rightAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: Settings.shared.dateFontHeight),
            
            tempLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            tempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            tempLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor),
            tempLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor),
            
//            chartView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
//            chartView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
//            chartView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
//            chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCell(_ date: String/*Date*/, _ averageTempOfDay: Int, _ dataOfAllDay: LineChartData){
//        let calendar = Calendar.current
//        self.dateLabel.text = "\(calendar.component(.day, from: date)) August"
        self.dateLabel.text = date
        self.tempLabel.text = "\(averageTempOfDay)°C " + emojiStates.randomElement()!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        backgroundColor = .white
        addViews()
        setLayout()
    }
    func addViews() {
        self.addSubview(dateLabel)
        self.addSubview(tempLabel)
    }

    func setData() {
        let set1 = LineChartDataSet(
            entries: Array(0..<30).map {index in
                ChartDataEntry(x: Double(index), y: Double(Array(0..<30).randomElement()!))
            }, label: "Forecast")
        let data = LineChartData(dataSet: set1)
        chartView.data = data
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
