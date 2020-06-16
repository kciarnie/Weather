//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Kevin on 2020-06-15.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UILabel?
    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var rainPrecipitationLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var lowTemperatureLabel: UILabel?

    static let identifier = "ForecastTableViewCell"
    static let cellHeight = CGFloat(80)

    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: nil)
    }

    func configure(with model: DailyDataPoint?, city: City, timezone: TimeZone) {
        self.icon?.text = model?.icon.iconString
        self.dayLabel?.text = WeatherDateTime(date: model?.time ?? 0, timeZone: timezone).getDayTime() //getDayForDate(model?.time)
        self.summaryLabel?.text = model?.summary
        self.rainPrecipitationLabel?.isHidden = (model?.precipProbability == 0 || model?.precipProbability ?? 0 < 0.2)
        self.rainPrecipitationLabel?.text = model?.precipProbability?.showPercentage()
        self.highTemperatureLabel?.text = model?.temperatureHigh?.showAsTemperature(city)
        self.lowTemperatureLabel?.text = model?.temperatureLow?.showAsTemperature(city)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d YYYY"
        return formatter.string(from: inputDate)
    }
}
