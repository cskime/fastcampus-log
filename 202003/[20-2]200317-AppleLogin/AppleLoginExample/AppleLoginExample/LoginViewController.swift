//
//  LoginViewController.swift
//  AppleLoginExample
//
//  Created by Giftbot on 2020/03/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
  
  @IBOutlet private weak var stackView: UIStackView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAppleIDButton()
  }
  
  private func setupAppleIDButton() {
    let appleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    appleIDButton.cornerRadius = appleIDButton.frame.height / 2
    appleIDButton.addTarget(self, action: #selector(didTapAppleIDButton(_:)), for: .touchUpInside)
    stackView.addArrangedSubview(appleIDButton)
    stackView.arrangedSubviews.first?.isHidden = true
  }
  
  
  // MARK: Action
  
  @objc private func didTapAppleIDButton(_ sender: Any) {
    let idRequest = ASAuthorizationAppleIDProvider().createRequest()
    idRequest.requestedScopes = [.email, .fullName]   // 없으면 []
    
    let authorizationContrroller = ASAuthorizationController(authorizationRequests: [idRequest])
    authorizationContrroller.delegate = self
    authorizationContrroller.presentationContextProvider = self
    authorizationContrroller.performRequests()  // 실제 요청
  }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("실패")
    guard let error = error as? ASAuthorizationError else { return }
    
    switch error.code {
    case .unknown:
      print("Unknown")
    case .canceled:
      print("Cacneled")
    case .invalidResponse:
      print("InvalidResponse")
    case .notHandled:
      print("Not Handled")
    case .failed:
      print("Failed")
    @unknown default:
      print("Default")
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    print("성공")
    guard let idCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
      let idToken = idCredential.identityToken,
      let tokenString = String(data: idToken, encoding: .utf8) else { return }
    
    print(tokenString)  // backend(server)와 작업할 때 사용하게 됨. 서버에 tokenString 저장
    
    
    let userID = idCredential.user
    let familyName = idCredential.fullName?.familyName ?? ""
    let givenName = idCredential.fullName?.givenName ?? ""
    let email = idCredential.email ?? ""
    
    let user = User(id: userID, familyName: familyName, givenName: givenName, email: email)
    print(user)
    
    // 한번 로그인하면 이후부터는 정보를 제공하지 않음. 받은 정보를 일단 로컬에 저장해 둬야 한다.
    // 서버에 저장해서 사용자가 앱을 지우거나 다른 기기로 교체했을 때에도 사용 가능하게
    if let encodedData = try? JSONEncoder().encode(user) {
      UserDefaults.standard.set(encodedData, forKey: "AppIDData")
      print(encodedData)
    }
    
    switch idCredential.realUserStatus {
    case .likelyReal:
      print("아마도 실제 사용자일 가능성이 높음")
    case .unknown:
      print("실제 사용자인지 봇인지 확실하지 않음")   // 추가 확인 단계 등을 거칠 수 있음
    case .unsupported:
      print("iOS가 아님. Sign In With Apple은 iOS에서만 지원")
    default:
      break
    }
    
    let vc = presentingViewController as! ViewController
    vc.user = user
    dismiss(animated: true)
  }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}
