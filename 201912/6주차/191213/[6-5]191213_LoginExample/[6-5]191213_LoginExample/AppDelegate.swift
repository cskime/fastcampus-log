//
//  AppDelegate.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        if #available(iOS 13.0, *) {
        //            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        //                let window = UIWindow(windowScene: windowScene)
        //                window.rootViewController = ViewController()
        //
        //                (windowScene.delegate as? SceneDelegate)?.window = window
        //                window.makeKeyAndVisible()
        //            }
        //        } else {
        //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //            let window = UIWindow(frame: UIScreen.main.bounds)
        //            window.rootViewController = ViewController()
        //            window.makeKeyAndVisible()
        //
        //        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

