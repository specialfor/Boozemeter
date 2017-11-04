//
//  SplashRouter.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SplashRouter {
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }()
    
    var rootViewController: UIViewController {
        if let _ = StorageService.default.person {
            showDashboard()
        } else {
            showInitial()
        }
        
        return navigationController
    }
    
    // MARK: Singleton
    static let shared = SplashRouter()
    
    private init() {}
    
    // MARK: Routes
    func showInitial() {
        showModule(InitialViewController())
    }
    
    func showDashboard() {
        showModule(DashboardViewController())
    }
    
    private func showModule(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
        navigationController.viewControllers = [navigationController.viewControllers.last!]
    }
}
