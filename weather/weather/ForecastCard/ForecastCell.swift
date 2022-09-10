//
//  WalletCell.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import UIKit
import Charts

final class ForecastCell: UICollectionViewCell {
    let emojiStates: [String] = ["🌤", "⛅", "🌦", "🌧", "⛈", "🌩", "☁️" , "☀️", "🌨", "🧣"]
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Settings.shared.dateFontHeight)
        label.textAlignment = .left
        label.textColor = .black
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
        chartView.backgroundColor = .clear
        chartView.alpha = 0
        chartView.layer.cornerRadius = 10
        chartView.clipsToBounds = true
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = true
        chartView.legend.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.doubleTapToZoomEnabled = true
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.isMultipleTouchEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.zoomToCenter(scaleX: 4, scaleY: 1)
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: Settings.shared.dateFontHeight / 1.5)
        chartView.highlightPerTapEnabled = false
        chartView.dragYEnabled = false
        chartView.dragDecelerationEnabled = true
        chartView.highlightPerDragEnabled = false
        chartView.extraBottomOffset = chartView.xAxis.labelFont.xHeight
        chartView.moveViewToX(3)
        chartView.xAxis.axisLineColor = .clear
//        chartView.animate(yAxisDuration: 0.2)
        return chartView
    }()
    
    func setData(_ data: [ChartDataEntry]){
        let lineSet = LineChartDataSet(
            entries: data)
        lineSet.mode = .horizontalBezier
        lineSet.lineWidth = 3
        lineSet.drawValuesEnabled = true
        lineSet.setColor(NSUIColor(red: 107/255, green: 243/255, blue: 173/255, alpha: 1))
        lineSet.fill = Fill(color: NSUIColor(red: 107/255, green: 243/255, blue: 173/255, alpha: 1))
        lineSet.fillAlpha = 0.78
        lineSet.drawFilledEnabled = true
        lineSet.circleRadius = 0
        lineSet.valueFont = .boldSystemFont(ofSize: Settings.shared.dateFontHeight)
        lineSet.drawCirclesEnabled = false
        lineSet.valueFormatter = DefaultValueFormatter(decimals: 0)
        let chartData = LineChartData(dataSet: lineSet)
        chartData.setDrawValues(true)
        chartData.setValueTextColor(.black)
        chartView.alpha = 0
        self.chartView.data = chartData
        UIView.animate(withDuration: 0.2, animations: {
            self.chartView.alpha = 1
        })
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
    
    func configureCell(_ forecast: Forecast,_ data: [ChartDataEntry]?){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        
        self.dateLabel.text = formatter.string(from: forecast.date)
        self.tempLabel.text = "\(forecast.temp)°C " + emojiStates.randomElement()!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
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

extension ForecastCell:ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}
