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
        var viewController: UIViewController = InitialViewController()
        
        if let _ = StorageService.default.person {
            viewController = UIViewController()
        }
        
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    // MARK: Singleton
    static let shared = SplashRouter()
    
    private init() {}
    
    // MARK: Routes
    func showMain() {
        let viewController = UIViewController()
        navigationController.viewControllers = [viewController]
    }
}
