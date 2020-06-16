//
//  HeaderTableViewCell.swift
//  Weather
//
//  Created by Kevin on 2020-06-16.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

/**
This is a class which shows the main summary for the day of a city
*/
class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var iconString: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var cloudiness: UILabel!
    @IBOutlet weak var windspeed: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "HeaderTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: nil)
    }

    /**
    Sets up the HeaderTableViewCell. Sets all the labels

    - Parameter model: A DarkSkyViewModel which contains all the necessary information to convert the summary to the main screen
    - Parameter city: A city object which contains the name and coordinates

     */
    func configure(with model: DarkSkyViewModel?, city: City) {
        self.location.text = model?.location
        self.createDistinctSpacing(self.location, txt: model?.location ?? "")
        self.summary.text = model?.summary
        self.createDistinctSpacing(self.summary, txt: model?.summary ?? "")
        self.temperature.text = model?.temperature
        self.lowTemp.text = model?.lowTemperature
        self.highTemp.text = model?.highTemperature
        self.iconString.text = model?.icon
        self.feelsLike.text = model?.feelsLike
        self.sunrise.text = model?.sunrise
        self.sunset.text = model?.sunset
        self.humidity.text = model?.humidity
        self.pressure.text = model?.pressure
        self.cloudiness.text = model?.cloudiness
        self.windspeed.text = model?.windSpeed
    }
 
    func createDistinctSpacing(_ label: UILabel, txt: String) {
        label.addCharactersSpacing(spacing: 6.0, txt: txt)
    }
}
