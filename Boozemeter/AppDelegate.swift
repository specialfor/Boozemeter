//
//  AppDelegate.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Configure window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashRouter.shared.rootViewController
        window?.makeKeyAndVisible()
        
        // Facebook SDK
        FBSDKAppEvents.activateApp()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Twitter SDK
        Twitter.sharedInstance().start(withConsumerKey: Constants.Twitter.consumerKey, consumerSecret: Constants.Twitter.consumerSecret)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Facebook SDK
        var handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        // Twitter SDK
        handled = handled || Twitter.sharedInstance().application(app, open: url, options: options)
        
        return handled
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        StorageService.default.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageService.default.save()
    }
    
}

