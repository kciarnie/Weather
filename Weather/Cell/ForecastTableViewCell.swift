//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Kevin on 2020-06-15.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

/**
 This is a class which shows the day, weather icon, high/low temperatures and a small summary
 */
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

    /**
    Sets up the ForecastTableViewCell. Sets all the labels

    - Parameter model: A DailyDataPoint which contains all the necessary information for that specific day
    - Parameter city: A city object which contains the name and coordinates
    - Parameter timezone: the current timezone of the city
    - Parameter index: the current row number

     */
    func configure(with model: DailyDataPoint?, city: City, timezone: TimeZone, index: Int) {
        self.icon?.text = model?.icon.iconString
        
        let weatherDateTime = WeatherDateTime(date: model?.time ?? 0, timeZone: timezone)
        self.dayLabel?.text = index < 6 ? weatherDateTime.getDayString() : weatherDateTime.getDayAndMonth()
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
}
