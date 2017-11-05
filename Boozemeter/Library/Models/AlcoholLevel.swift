//
//  AlcoholLevel.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

enum AlcoholLevel: Int {
    case weak
    case norm
    case strong
    case death
    
    init?(value: Double) {
        switch value {
        case let x where x >= 4.0:
            self.init(rawValue: 3)
        case let x where x >= 2.0:
            self.init(rawValue: 2)
        case let x where x >= 0.6:
            self.init(rawValue: 1)
        case let x where x > 0:
            self.init(rawValue: 0)
        default:
            return nil
        }
        
    }
    
    var imageName: String {
        return AlcoholLevel.images[self.rawValue]
    }
    
    var color: UIColor {
        return AlcoholLevel.colors[self.rawValue]
    }
    
    private static let images: [String] = [
        "weak",
        "norm",
        "strong",
        "death"
    ]
    
    private static let colors: [UIColor] = [
        .green,
        .orange,
        .brown,
        .red
    ]
}
