//
//  SceneDelegate.swift
//  AppleLoginExample
//
//  Created by Giftbot on 2020/03/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    self.appleIDCredentialState()
  }
  
  func appleIDCredentialState() {
    guard let data = UserDefaults.standard.data(forKey: "AppleIDData"),
      let user = try? JSONDecoder().decode(User.self, from: data) else { return }
    
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    appleIDProvider.getCredentialState(forUserID: user.id) { (credentialState, error) in
      switch credentialState {
      case .authorized:
        print("Already Authorization")    // 이미 로그인된 경우
      case .revoked:
        print("Revoked")        // 사용중단
      case .notFound:
        print("Not Found")      // 가입 이력이 없을 때
      case .transferred:
        print("Transferred")    // 아직...
      @unknown default:
        print("Default")
      }
    }
  }
}
