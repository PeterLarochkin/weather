//
//  ViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import UIKit
import Charts
protocol HasIndexOfSelectedRow: AnyObject {
    func indexOfSelectedRow()-> Int?
}
final class CardController: UIViewController {
    
    var selectedRow: Int? = 0
    var currentCityId: String = "Hello"
    lazy var collectionView:  UICollectionView = {
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: CardLayout())
        let layout = CardLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "WalletCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegateIndexOfSelectedRow = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var forecasts: [Forecast] = WeatherManager.shared.loadWeatherForecast("Hello", .month, Date(),  Date())
    private let kCellHeight: CGFloat = Settings.shared.longHeightOfCard
    
    func setLayout() {
        let constraints = [
            collectionView.leftAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            collectionView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            collectionView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(collectionView)
        setLayout()
    }
}

extension CardController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath) as! CardCell
        
        let dayForecast = WeatherManager.shared.loadWeatherForecast(currentCityId, .day,  Date(),  Date())
        
        let chartData = dayForecast.enumerated().map { index, forecast in
            ChartDataEntry(x: Double(index + 1), y: Double(forecast.temp))
        }
        cell.configureCell(
            forecasts[indexPath.row],
            chartData,
            (indexPath.row == selectedRow) || (indexPath.row == forecasts.count - 1))
        return cell
    }
}

extension CardController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if forecasts.count - 1 == indexPath.row {
                //Last Card tap
            } else {
                if selectedRow == indexPath.item {
                    //Expanded card to redirection
                } else {
                    selectedRow = indexPath.row
                    self.collectionView.performBatchUpdates {
                    } completion: { (comp) in
                        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
                            let dayForecast = WeatherManager.shared.loadWeatherForecast(self.currentCityId, .day,  Date(),  Date())

                            let chartData = dayForecast.enumerated().map { index, forecast in
                                BarChartDataEntry(x: Double(index+1), y: Double(forecast.temp))
                            }
                            cell.chartView.isHidden = false
                            cell.setData(chartData)
                            
                        }
                        
                        
                    }
                }
            }
//            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - Settings.shared.standartOffSets.left - Settings.shared.standartOffSets.right, height: CGFloat(kCellHeight))
    }
}

extension CardController: HasIndexOfSelectedRow {
    func indexOfSelectedRow() -> Int? {
        return selectedRow
    }
}
