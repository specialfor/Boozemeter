//
//  Person.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

struct Person: Codable {
    var height: Double
    var weight: Double
    var sex: Sex
    
    init() {
        height = 0
        weight = 0
        sex = .male
    }
}
