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
        label.text = "🌡️"
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: Settings.shared.dateFontHeight,
            weight: .regular)
        label.textColor = .gray
        label.layer.shadowOffset = CGSize(width: 3, height: 0)
        label.layer.shadowOpacity = 1
        label.text = "☔"
        return label
    }()
    
    private func setLayout(){
        var constraints = [
            dateLabel.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: 8),
            dateLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 4),
            dateLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -4),
            dateLabel.rightAnchor.constraint(
                equalTo: humidityLabel.leftAnchor,
                constant: -4)
        ]
        constraints += [
            tempLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: -8),
            tempLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 4),
            tempLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -4),
            tempLabel.widthAnchor.constraint(
                equalToConstant: 3 * Settings.shared.dateFontHeight)
        ]
        constraints += [
            humidityLabel.rightAnchor.constraint(
                equalTo: tempLabel.leftAnchor,
                constant: -4),
            humidityLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 4),
            humidityLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -4),
            tempLabel.widthAnchor.constraint(
                equalToConstant: 3 * Settings.shared.dateFontHeight)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCell(_ forecast: Forecast, for period: Period){
        self.humidityLabel.text = "\(forecast.airHumidity)%"
        self.tempLabel.text = "\(forecast.temp)%"
        let calendar = Calendar.current
        switch period {
        case .day:
            self.dateLabel.text = "\(calendar.component(.hour, from: forecast.date))"
        case .week:
            self.dateLabel.text = "\(calendar.component(.day, from: forecast.date))"
        case .month:
            self.dateLabel.text = "\(calendar.component(.day, from: forecast.date))"
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
