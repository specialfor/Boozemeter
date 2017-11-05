//
//  AlcoholState.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

struct AlcoholState: Codable {
    var concentration: Double
    var timestamp: TimeInterval
    var resorptionTimestamp: TimeInterval
}
