//
//  AppDelegate.swift
//  BasicLoginPage
//
//  Created by cskim on 2019/12/30.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaults.standard.bool(forKey: UserInfoKey.isLogined) {
            window?.rootViewController = MainViewController()
        } else {
            window?.rootViewController = SignInViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
}

