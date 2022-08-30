//
//  ForecastTableViewCell.swift
//  weather
//
//  Created by Петр Ларочкин on 17.08.2022.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: Settings.shared.dateFontHeight,
            weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: Settings.shared.dateFontHeight,
            weight: .regular)
        label.textColor = .gray
        label.textAlignment = .right
        label.text = "🌡️"
        
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: Settings.shared.dateFontHeight,
            weight: .regular)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.text = "☔"
        return label
    }()
    
    private func setLayout(){
        let constraints = [
            dateLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Settings.shared.standartOffSets.left),
            dateLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            dateLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom),
            dateLabel.rightAnchor.constraint(
                equalTo: self.centerXAnchor),
            
            humidityLabel.leftAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: Settings.shared.standartOffSets.left),
            humidityLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            humidityLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom),
            humidityLabel.rightAnchor.constraint(
                equalTo: tempLabel.leftAnchor),
            
            tempLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: Settings.shared.standartOffSets.right),
            tempLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Settings.shared.standartOffSets.top),
            tempLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: Settings.shared.standartOffSets.bottom),
            tempLabel.widthAnchor.constraint(
                equalToConstant: 5 * Settings.shared.dateFontHeight),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCell(_ forecast: Forecast, for period: Period){
        self.humidityLabel.text = "\(forecast.airHumidity)% 💧"
        self.tempLabel.text = " \(forecast.temp)°C " + forecast.emojiState
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd'th of MMMM"
        
        switch period {
        case .day:
            self.dateLabel.text = formatter.string(from: forecast.date)
        case .month:
            self.dateLabel.text = formatter.string(from: forecast.date)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(tempLabel)
        addSubview(humidityLabel)
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
