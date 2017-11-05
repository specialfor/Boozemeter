//
//  AlcoholStateService.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

protocol AlcoholStateServiceDelegate: class {
    func didAlcoholStateUpdated(_ service: AlcoholStateService, state: AlcoholState)
}

class AlcoholStateService {
    
    weak var delegate: AlcoholStateServiceDelegate?
    
    private(set) var alcoholState: AlcoholState {
        didSet {
            StorageService.default.alcoholState = alcoholState
        }
    }
    
    private let alcoholCalculator: AlcoholCalculator
    private var timer: Timer?
    private let timeInterval: TimeInterval = 60
    
    // MARK: Singleton
    static let shared = AlcoholStateService()
    
    private init() {
        alcoholCalculator = AlcoholCalculator()
        alcoholState = StorageService.default.alcoholState
        
        alcoholState = alcoholCalculator.calculateAlcoholState(from: alcoholState)
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK:
    func updateStateWith(drink: SelectedDrink) {
        let concentration = alcoholCalculator.calculateConcentration(for: StorageService.default.person!, withDrink: drink)
        
        alcoholState.concentration += concentration
        alcoholState.timestamp = Date().timeIntervalSince1970
        alcoholState.resorptionTimestamp = alcoholCalculator.timeUntilSobering(alcoholState.concentration, timestamp: alcoholState.timestamp)
        
        delegate?.didAlcoholStateUpdated(self, state: alcoholState)
    }
    
    // MARK: Timer
    @objc private func timerFired() {
        alcoholState = alcoholCalculator.calculateAlcoholState(from: alcoholState)
        
        delegate?.didAlcoholStateUpdated(self, state: alcoholState)
    }
}
