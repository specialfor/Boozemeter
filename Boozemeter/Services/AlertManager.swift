//
//  LocalAuthService.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {

    static let sharedInstance : AlertManager = {
        let instance = AlertManager()
        return instance
    }()

    func showAlertOk(title: String, message: String, completion:(()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: Constants.LocalizableKeys.ok.localized, style: .default) { (action) in
            completion?()
        }
        alert.addAction(defaultAction)
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertOk(message: String, completion:(()->Void)? = nil) {
        showAlertOk(title: "", message: message, completion: completion)
    }
    
    func showAlertOkCancel(message: String, completionOk:(()->Void)? = nil, completionCancel:(()->Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: Constants.LocalizableKeys.ok.localized, style: .default) { (action) in
            completionOk?()
        }
        alert.addAction(defaultAction)
        
        let secondAction = UIAlertAction(title: Constants.LocalizableKeys.cancel.localized, style: .cancel) { (action) in
            completionCancel?()
        }
        alert.addAction(secondAction)
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionSheet.addAction($0) }
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(actionSheet, animated: true, completion: nil)
    }
    
}
