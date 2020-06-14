//
//  CityCellTableViewCell.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {
    
    @IBOutlet var subTitleLabel: UILabel?
        @IBOutlet var mainTitleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
