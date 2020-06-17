//
//  CityCellTableViewCell.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

/**
 This is the TableViewCell for the main ViewController.swift class
 It has a main label, and a sublabel
 */
class CityCellTableViewCell: UITableViewCell {
    
    @IBOutlet var subTitleLabel: UILabel?
    @IBOutlet var mainTitleLabel: UILabel?

    static let cellHeight = CGFloat(80)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Used to configure the cell
     
     - Parameter city: The city object
     */
    func configure(_ city: City) {
        mainTitleLabel?.text = city.name
        subTitleLabel?.text = city.country
        backgroundColor = Constants.backgroundColor
        mainTitleLabel?.textColor = Constants.textColor
        subTitleLabel?.textColor = Constants.textColor

        selectionStyle = .none
    }
}
