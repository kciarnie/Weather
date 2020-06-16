//
//  UI+Extensions.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // Convienently creates a UIColor constructor which takes in a hex value and alpha for use in Constants.swift
    convenience init(hex: UInt, alphaVal: CGFloat) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}

extension UILabel {
    
    // Used to properly space the characters of a string for displaying. The user can set the spacing between each
    // variable
    func addCharactersSpacing(spacing: CGFloat, txt: String) {
        let attributedString = NSMutableAttributedString(string: txt)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: txt.count))
        self.attributedText = attributedString
    }
}
