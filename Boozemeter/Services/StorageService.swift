//
//  StorageService.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

class StorageService {
    
    private struct Keys {
        static let person = "person"
        static let alcoholState = "alcoholState"
        static let shouldUseTouchId = "shouldUseTouchId"
    }
    
    let userDefaults = UserDefaults.standard
    
    var person: Person?
    var alcoholState: AlcoholState!
    var shouldUseTouchId: Bool!
    
    // MARK: Singleton
    static let `default` = StorageService()
    
    private init() {
        person = read(modelOf: Person.self, forKey: Keys.person)
        
        if let alcoholState = read(modelOf: AlcoholState.self, forKey: Keys.alcoholState) {
            self.alcoholState = alcoholState
        } else {
            self.alcoholState = AlcoholState()
        }
        
        self.shouldUseTouchId = UserDefaults.standard.bool(forKey: Keys.shouldUseTouchId)
    }
    
    // MARK: Save
    func save() {
        let _ = write(model: person, forKey: Keys.person)
        let _ = write(model: alcoholState, forKey: Keys.alcoholState)
        UserDefaults.standard.set(shouldUseTouchId, forKey: Keys.shouldUseTouchId)
    }
    
    // MARK: Write & read from defaults
    private func write<T: Encodable>(model: T?, forKey key: String) -> Bool {
        guard model != nil else {
            userDefaults.set(nil, forKey: key)
            return true
        }
        
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(model) else {
            return false
        }
        
        userDefaults.set(data, forKey: key)
        return true
    }
    
    private func read<T: Decodable>(modelOf type: T.Type, forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        
        
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
    
}
