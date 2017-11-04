//
//  Sex.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
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
