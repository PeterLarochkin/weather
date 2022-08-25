//
//  WalletCell.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import UIKit

class WalletCell: UICollectionViewCell {
    




    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        backgroundColor = .white
        addViews()
    }
    func addViews() { }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
