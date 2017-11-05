//
//  AlcoholCalculator.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

enum TimeValue: Int {
    case hours
    case minutes
    case seconds
    case miliseconds
    
    var factor: Double {
        return TimeValue.factors[self.rawValue]
    }
    
    private static let factors: [Double] = [1/60, 1, 60, 60 * 100]
}

class AlcoholCalculator {
    
    private let density = 0.789
    private let sLength = 0.2
    private let sOffset = 0.1
    private let respCoef = 0.15
    
//    // TODO: set
//    private(set) var currentConcentration: Double = 0
//
//    let person = StorageService.default.person
    
    func calculateConcentration(for person: Person, withDrink drink: SelectedDrink) -> Double {
        let sex = person.sex
        
        let pHeight = person.height / 100.0
        
        let height = sqrt(person.weight / sex.bmi)
        let alcoMass = Double(drink.size) * drink.turnover * density
        
        let dHeight = pHeight / height
        
        let conc = alcoMass / (person.weight * dHeight * sex.factor)
        let concWithLosses = conc * (1 - (drink.satiety * sLength + sOffset))
        
        return concWithLosses
    }
    
    func timeUntilSobering(_ concentration: Double, timeValue: TimeValue = .minutes) -> TimeInterval {
        return 60 * timeValue.factor * (concentration / respCoef)
    }
    
}
