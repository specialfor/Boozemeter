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
        configureNavBar()
        showModule(DashboardViewController())
    }
    
    func showDrinks() {
        showModule(DrinksViewController(), popPrev: false)
    }
    
    private func showModule(_ viewController: UIViewController, animated: Bool = true, popPrev: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        
        if popPrev {
            navigationController.viewControllers = [navigationController.viewControllers.last!]
        }
    }
    
    private func configureNavBar() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let navigationBar = navigationController.navigationBar
        
        let theme = ThemeManager.shared.theme
        
        navigationBar.barTintColor = theme.mainColor
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.tintColor = theme.selectedTextColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.selectedTextColor]
        
        navigationController.isNavigationBarHidden = false
    }
}
