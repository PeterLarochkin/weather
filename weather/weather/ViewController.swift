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
class ViewController: UIViewController {
    
    var selectedRow: Int?
    lazy var collectionView:  UICollectionView = {
        let cv = UICollectionView(frame: .null, collectionViewLayout: CardLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    var virtualCardList = [String]()
    private let kCellHeight: CGFloat = 250
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        let constraints = [
            collectionView.leftAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            collectionView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        for i in 0..<31 {
            virtualCardList.append("card\(i)")
        }
        let layout = CardLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "WalletCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegateIndexOfSelectedRow = self
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return virtualCardList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCell", for: indexPath) as! CardCell
        cell.configureCell("\(indexPath.row) August", Array(25..<32).randomElement()!, LineChartData())
        return cell
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if virtualCardList.count - 1 == indexPath.row {
            //Last Card tap
        }else{
            if selectedRow == indexPath.item {
                //Expanded card to redirection
            }else{
                selectedRow = indexPath.row
                self.collectionView.performBatchUpdates {
                } completion: { (comp) in
                    
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: CGFloat(kCellHeight))
    }
}

extension ViewController: HasIndexOfSelectedRow {
    func indexOfSelectedRow() -> Int? {
        return selectedRow
    }
}
