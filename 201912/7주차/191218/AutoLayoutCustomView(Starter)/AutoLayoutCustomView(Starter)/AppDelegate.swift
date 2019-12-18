//
//  AppDelegate.swift
//  AutoLayoutCustomView(Starter)
//
//  Created by Lee on 2019/12/18.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = EmailViewController()
    window?.makeKeyAndVisible()
    
    return true
  }

}

