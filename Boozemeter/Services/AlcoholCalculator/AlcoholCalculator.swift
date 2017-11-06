//
//  AlcoholCalculator.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

class AlcoholCalculator {
    
    private let density = 0.789
    private let sLength = 0.2
    private let sOffset = 0.1
    private let respCoef = 0.15
    
    func calculateConcentration(for person: Person, withDrink drink: SelectedDrink) -> Double {
        
        let alcoMass = Double(drink.size) * drink.turnover * density
        
        let conc = alcoMass / self.secondFactor(from: person)
        let concWithLosses = conc * (1 - (drink.satiety * sLength + sOffset))
        
        return concWithLosses
    }
    
    func calculateAlcoholState(from state: AlcoholState) -> AlcoholState {
        let concentration = self.calculateConcentration(with: state.concentration, from: state.timestamp)
        
        let timestamp = Date().timeIntervalSince1970
        
        return AlcoholState(concentration: concentration, timestamp: timestamp, resorptionTimestamp: timeUntilSobering(concentration, timestamp: timestamp))
    }
    
    func recalculateState(_ state: AlcoholState, fromPerson person: Person) -> AlcoholState {
        let alcoMass = state.concentration * secondFactor(from: person)
        
        let concentration = alcoMass / secondFactor(from: StorageService.default.person!)
        
        let timestamp = Date().timeIntervalSince1970
        
        return AlcoholState(concentration: concentration, timestamp: timestamp, resorptionTimestamp: timeUntilSobering(concentration, timestamp: timestamp))
    }
    
    func calculateConcentration(with concentration: Double, from timestamp: TimeInterval) -> Double {
        
        let timeInterval = Date().timeIntervalSince1970 - timestamp
        
        let newConc = max(concentration - (respCoef * timeInterval / TimeValue.seconds.factor / 60), 0)
        
        return newConc
    }
    
    func timeUntilSobering(_ concentration: Double, timestamp: TimeInterval, timeValue: TimeValue = .seconds) -> TimeInterval {
        return timestamp + 60 * timeValue.factor * (concentration / respCoef)
    }
    
    private func secondFactor(from person: Person) -> Double {
        let sex = person.sex
        let pHeight = person.height / 100.0
        let height = sqrt(person.weight / sex.bmi)
        
        let dHeight = pHeight / height
        
        return person.weight * dHeight * sex.factor
    }
    
}
