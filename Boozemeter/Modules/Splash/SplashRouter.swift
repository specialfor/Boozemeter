//
//  SplashRouter.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SplashRouter {
    
    let overlayVC = AccessDeclinedViewController()
    
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
    
    func dismissToDashboard() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showDrinks() {
        showModule(DrinksViewController(), popPrev: false)
    }
    
    func showSelectDrink(_ drink: Drink) {
        let viewController = SelectDrinkViewController()
        viewController.drink = drink
        showModule(viewController, popPrev: false)
    }
    
    func showSettings() {
        showModule(SettingsViewController(), popPrev: false)
    }
    
    func showOverlay() {
        overlayVC.hide()
        present(overlayVC)
    }
    
    func showAccessDenied(with title: String?) {
        overlayVC.titleLabel.text = title
        overlayVC.show()
    }
    
    private func present(_ viewController: UIViewController, animated: Bool = true) {
        if navigationController.presentedViewController != viewController {
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func dismiss(_ animated: Bool = true) {
        navigationController.dismiss(animated: animated, completion: nil)
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
