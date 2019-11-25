//
//  AppDelegate.swift
//  [4-1]191125_ViewControllerExample
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // iOS 12 이하에서 만들 때는 window 객체를 둘 다 추가해줘야함
    // iOS 13부터는 sceneDelegate가 기본으로 사용되면서 window 객체가 sceneDelegate에서만 사용됨
    // target을 13 이하로 잡으면 반드시 두 경우를 모두 지원해야함
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // iOS 13에서는 AppDelegate와 SceneDelegate 둘 다 호출되어 의미 없는 코드가 되어버림
        // iOS 13에서는 이 코드를 호출하지 않게 만듦
        if #available(iOS 13.0, *) {
        } else {
            /* iOS 12 이하에서 storyboard 대신 code로 window부터 생성하기 */
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = FirstViewController()
            window?.rootViewController?.view.backgroundColor = .white
            window?.makeKeyAndVisible()                      // window는 여러 개가 있을 수 있고, key window가 필요함
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    // 지워도 기본 값이 사용됨
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

