//
//  AppDelegate.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/5/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        
        return true
    }
}
