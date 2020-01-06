//
//  AppDelegate.swift
//  MyApp
//
//  Created by cskim on 2020/01/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // iOS 13 이상에서 다른 함수를 쓰기 때문에, 여기서 쓰려면 SceneDelegate에서 사용해야함
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("sourceApplication :", options[.sourceApplication] ?? "")
        print("app :", app)
        print("url :", url)
        
        if let scheme = url.scheme {
            print("scheme :", scheme)
        }
        if let host = url.host {
            print("host :", host)
        }
        if let query = url.query {
            print("query :", query)
        }
        return true
    }
    
    
}

