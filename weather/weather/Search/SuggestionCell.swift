//
//  SuggestionCell.swift
//  weather
//
//  Created by Петр Ларочкин on 20.07.2022.
//

import UIKit

final class SuggestionCell: UITableViewCell {
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .boldSystemFont(ofSize: Settings.shared.cityFontHeight)/
        label.numberOfLines = -1
        label.font = .systemFont(ofSize: Settings.shared.cityFontHeight, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    var lastWeatherStatusLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Settings.shared.cityFontHeight)
        return label
    }()

    private func layoutLabels() {
        NSLayoutConstraint.activate([
//            lastWeatherStatusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
//            lastWeatherStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//            lastWeatherStatusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
//            lastWeatherStatusLabel.widthAnchor.constraint(equalToConstant: Settings.shared.cityFontHeight),
            cityLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Settings.shared.standartOffSets.left),
            cityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: Settings.shared.standartOffSets.bottom),
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Settings.shared.standartOffSets.top),
            cityLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Settings.shared.standartOffSets.right),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.addSubview(cityLabel)
//        self.addSubview(lastWeatherStatusLabel)
        layoutLabels()
    }
    
    func configureCell(_ city: City){
        self.cityLabel.text = city.name //+ " \(city.center.0), \(city.center.1)"
        self.lastWeatherStatusLabel.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

