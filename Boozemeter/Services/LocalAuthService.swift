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

typealias AuthCompletion = (Bool, String?) -> Void

class LocalAuthService {
    
    let context: LAContext
    
    init() {
        self.context = LAContext()
    }
    
    static func tryAuth() {
        if StorageService.default.shouldUseTouchId {
            SplashRouter.shared.showOverlay()
            
            let authService = LocalAuthService()
            // TODO: reason description
            authService.auth(with: .passcode, reason: "need to think about it") { success, message in
                DispatchQueue.main.async {
                    if success {
                        SplashRouter.shared.dismiss(true)
                    } else {
                        SplashRouter.shared.showAccessDenied(with: message)
                    }
                }
            }
        }
    }
    
    func canAuth(with type: AuthType) -> Bool {
        var error: NSError?
        
        let result = context.canEvaluatePolicy(type.policy, error: &error)
        
        if let error = error as? LAError, error.code != .userFallback, error.code != .userCancel {
            AlertManager.sharedInstance.showAlertOk(message: error.localizedDescription)
        }
        
        return result
    }
    
    func auth(with type: AuthType, reason: String, completion: @escaping AuthCompletion) {
        context.evaluatePolicy(type.policy, localizedReason: reason) { (result, error) in
            guard let error = error as? LAError else {
                completion(true, nil)
                return
            }

            if error.code != .userFallback {
                completion(false, error.localizedDescription)
            }
        }
    }
    
}
