//
//  Rain.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

struct Rain: Codable {
    let onehour: Double?
    let threehour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case onehour = "1h"
        case threehour = "3h"
    }
}
