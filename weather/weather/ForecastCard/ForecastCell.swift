//
//  WalletCell.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import UIKit
import Charts

final class ForecastCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        lineSet.visible = true
        let chartData = LineChartData(dataSet: lineSet)
        chartData.setDrawValues(true)
        chartData.setValueTextColor(.black)
        self.chartView.data = chartData
        if chartView.alpha == 0 {
//            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.chartView.alpha = 1
                }, completion: nil)
//            }
        }
    }
    
    func setLayout() {
        let constraints = [
            containerView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            containerView.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            containerView.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            containerView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom),
            
            dateLabel.leftAnchor.constraint(
                equalTo: containerView.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            dateLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            dateLabel.rightAnchor.constraint(
                equalTo: containerView.centerXAnchor),
            dateLabel.heightAnchor.constraint(
                equalToConstant:
                    Settings.shared.dateFontHeight + 2 * Settings.shared.standartOffSets.top),
            
            tempLabel.rightAnchor.constraint(
                equalTo: containerView.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            tempLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            tempLabel.leftAnchor.constraint(
                equalTo: dateLabel.rightAnchor),
            tempLabel.heightAnchor.constraint(
                equalTo: dateLabel.heightAnchor),
            
            chartView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Settings.shared.shortHeightOfCard),
            chartView.leftAnchor.constraint(
                equalTo: containerView.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            chartView.rightAnchor.constraint(
                equalTo: containerView.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            chartView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        
    }
    
    func configureCell(_ forecast: Forecast,_ data: [BarChartDataEntry]?){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        
        self.dateLabel.text = formatter.string(from: forecast.date)
        self.tempLabel.text = "\(forecast.temp)°C " + forecast.emojiState
        
        if let data = data {
            
            
            self.setData(data)
            setData(data)
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.chartView.alpha = 0
            }, completion: nil)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        chartView.alpha = 0
        addViews()
        setLayout()

        
    }
    func addViews() {
        containerView.addSubview(dateLabel)
        containerView.addSubview(tempLabel)
        containerView.addSubview(chartView)
        self.addSubview(containerView)
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
