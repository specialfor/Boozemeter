//
//  LocalAuthService.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import LocalAuthentication

enum AuthType {
    case passcode
    case touchId
    
    var policy: LAPolicy {
        switch self {
        case .passcode:
            return .deviceOwnerAuthentication
        case .touchId:
            return .deviceOwnerAuthenticationWithBiometrics
        }
    }
}

class LocalAuthService {
    
    let context: LAContext
    
    init() {
        self.context = LAContext()
    }
    
    func canAuth(with type: AuthType) -> Bool {
        var error: NSError?
        
        let result = context.canEvaluatePolicy(type.policy, error: &error)
        
        if let error = error as? LAError, error.code != .userFallback, error.code != .userCancel {
            AlertManager.sharedInstance.showAlertOk(message: error.localizedDescription)
        }
        
        return result
    }
    
    func auth(with type: AuthType, reason: String) {
        context.evaluatePolicy(type.policy, localizedReason: reason) { (result, error) in
            if let error = error as? LAError, error.code != .userFallback, error.code != .userCancel {
                AlertManager.sharedInstance.showAlertOk(message: error.localizedDescription)
            }
        }
    }
    
}
