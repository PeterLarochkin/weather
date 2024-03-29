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
struct HelloWorld: Codable {
    let stringsss: String
}
final class ForecastViewController: UIViewController {
	private let output: ForecastViewOutput
    
    private var selectedRow: Int? = 0
    private var forecasts: [Forecast]?
    private var dataForOpenedCell: [IndexPath:[BarChartDataEntry]] = [IndexPath:[BarChartDataEntry]]()
    
    init(output: ForecastViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView:  UICollectionView = {
        let collectionView = UICollectionView(frame: .null, collectionViewLayout: CardLayout())
        let layout = CardLayout()
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegateIndexOfSelectedRow = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
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
        self.view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        setLayout()
        
        output.viewDidLoad()
    }
}

extension ForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let forecasts = self.forecasts {
            return forecasts.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        }
        
        if let forecasts = self.forecasts {
            if (selectedRow == indexPath.item) || (forecasts.count - 1 == indexPath.item){
                if let data = dataForOpenedCell[indexPath]  {
                    cell.configureCell(forecasts[indexPath.item], data)
                } else {
                    output.needDataForCell(at: indexPath)
                }
            } else {
                cell.configureCell(forecasts[indexPath.item], nil)
            }
        }
        return cell
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let forecasts = self.forecasts {
            if forecasts.count - 1 == indexPath.item {
                //Last Card tap
            } else {
                if selectedRow == indexPath.item {
                    //Expanded card to redirection
                } else {
                    selectedRow = indexPath.item
                    self.collectionView.performBatchUpdates {
                    } completion: { (comp) in
                        if let data = self.dataForOpenedCell[indexPath],
                           let cell = collectionView.cellForItem(at: indexPath) as? ForecastCell{
                            cell.configureCell(forecasts[indexPath.item], data)
                        } else {
                            self.output.needDataForCell(at: indexPath)
                        }
                    }
                }
            }
        }
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
    //MARK: run once
    func setHeaders(with forecasts: [Forecast]) {
        DispatchQueue.main.async {
            self.forecasts = forecasts
            debugPrint(forecasts)
            self.collectionView.reloadData()
        }
    }
    
    func setDataForCell(for data: [BarChartDataEntry], to indexPath: IndexPath) {
        DispatchQueue.main.async {
            if  let cell = self.collectionView.cellForItem(at: indexPath) as? ForecastCell,
                let forecasts = self.forecasts {
//                debugPrint("setDataForCell")
                self.dataForOpenedCell[indexPath] = data
                cell.configureCell(forecasts[indexPath.item], data)
            }
            
        }
    }
}
