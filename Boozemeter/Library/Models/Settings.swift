//
//  Settings.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

struct Settings: Codable {
    var person: Person
    var useTouchId: Bool
    var coeficients: [Double]
}
