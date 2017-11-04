//
//  Person.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

enum Sex: Int, Codable {
    case male
    case female
    
    private static let titles = ["Муж.", "Жен."]
    private static let factors = [0.7, 0.6]
    
    var title: String {
        return Sex.titles[self.rawValue]
    }
    
    var factor: Double {
        return Sex.factors[self.rawValue]
    }
}

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
