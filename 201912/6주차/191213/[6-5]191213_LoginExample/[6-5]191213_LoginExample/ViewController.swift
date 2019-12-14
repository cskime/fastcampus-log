//
//  ViewController.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

// Sign in => 화면전환 => User ID, Dismiss button
// Sign up => email, password 입력해서 저장
// UserDefaults 사용 => email, password, login status

import UIKit

class ViewController: UIViewController {

    let logoView = LogoView()
    let inputForm = FormContainerView()
    let signView = SignContainerView()
    
    let inputTextField = FormTextField(placeholder: "Test", image: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private var constraint: NSLayoutConstraint!
    let constant: CGFloat = 48
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupConstraints()
        inputForm.setTextFieldDelegate(self)
    }
    
    private func setupConstraints() {
        
        // Logo View
        
        let logoTopPadding: CGFloat = 100
        let logoPadding: CGFloat = 48
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: logoTopPadding),
            logoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: logoPadding),
            logoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -logoPadding),
        ])
        
        // Sign Button
        
        let signPadding: CGFloat = 24
        let signBottomPadding: CGFloat = 48
        signView.setButtonDelegate(self)
        view.addSubview(signView)
        signView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -signBottomPadding),
            signView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: signPadding),
            signView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -signPadding),
        ])
        
        
        // Input Form
        
        let formPadding: CGFloat = 32
        view.addSubview(inputForm)
        inputForm.translatesAutoresizingMaskIntoConstraints = false
        constraint = inputForm.bottomAnchor.constraint(equalTo: self.signView.topAnchor, constant: -constant)
        NSLayoutConstraint.activate([
            inputForm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: formPadding),
            inputForm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -formPadding),
            constraint,
        ])
    }
}

extension ViewController: SignButtonDelegate {
    func signInTouched() {
        if inputForm.canSignIn(), let userInfo = inputForm.fetch() {
            let mainVC = MainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            
            UserDefaults.standard.set(true, forKey: UserInfoKey.isLogined)
            UserDefaults.standard.set(userInfo.email, forKey: UserInfoKey.loginedEmail)
            UserDefaults.standard.set(userInfo.password, forKey: UserInfoKey.loginedPassword)
            
            present(mainVC, animated: true)
        }
    }
    
    func signUpTouched() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) {
            self.constraint.constant = -self.constant*4
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) {
            self.constraint.constant = -self.constant
            self.view.layoutIfNeeded()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 글자수 16자 제한. delete는 empty string.
        if string.isEmpty || textField.text!.count < 16 {
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
