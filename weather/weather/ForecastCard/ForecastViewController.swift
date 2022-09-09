//
//  ForecastViewController.swift
//  weather
//
//  Created by Петр Ларочкин on 07.09.2022.
//  
//

import UIKit
import Charts
protocol HasIndexOfSelectedRow {
    func indexOfSelectedRow() -> Int?
}

final class ForecastViewController: UIViewController {
	private let output: ForecastViewOutput

    init(output: ForecastViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var selectedRow: Int? = 0
    var currentCityId: String = "Hello"
    lazy var collectionView:  UICollectionView = {
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: CardLayout())
        let layout = CardLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegateIndexOfSelectedRow = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var forecasts: [Forecast] = Array.init(
        repeating: Forecast(date: Date(), airHumidity: 35, temp: 22, emojiState: "!"),
        count: 22)
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





extension ForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ForecastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        
//        let dayForecast: [Forecast] = [Forecast(date: Date(), airHumidity: 22, temp: 22, emojiState: "!")]
//
//        let chartData: [ChartDataEntry] = []
//        cell.configureCell(
//            forecasts[indexPath.row],
//            chartData,
//            (indexPath.row == selectedRow) || (indexPath.row == forecasts.count - 1))
        return cell
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
                        if let cell = collectionView.cellForItem(at: indexPath) as? ForecastCell {
                            let dayForecast: [Forecast] = []
                            let chartData : [BarChartDataEntry] = [BarChartDataEntry(x: 30.0, y: 20.0)]
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

extension ForecastViewController: HasIndexOfSelectedRow {
    func indexOfSelectedRow() -> Int? {
        return selectedRow
    }
}

extension ForecastViewController: ForecastViewInput {
}
