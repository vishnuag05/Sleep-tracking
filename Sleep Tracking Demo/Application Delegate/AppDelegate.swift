//
//  AppDelegate.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit
import CoreMotion
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Override point for customization after application launch.
        let homeVC = HomeViewController.init()
        window = UIWindow()
        window?.makeKeyAndVisible()
        let navController = UINavigationController.init(rootViewController: homeVC)
        window?.rootViewController = navController
        return true
    }
}

