//
//  TimeValue.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

enum TimeValue: Int {
    case hours
    case minutes
    case seconds
    case miliseconds
    
    var factor: Double {
        return TimeValue.factors[self.rawValue]
    }
    
    private static let factors: [Double] = [1/60, 1, 60, 6000]
}
