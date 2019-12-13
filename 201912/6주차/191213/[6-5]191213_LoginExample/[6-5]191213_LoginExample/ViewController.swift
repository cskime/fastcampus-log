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
    let inputFormContainer = FormContainerView()
    let signContainerView = SignContainerView()
    
    let inputTextField = FormTextField(placeholder: "Test", image: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private var constraint: NSLayoutConstraint!
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupConstraints()
        inputFormContainer.setTextFieldDelegate(self)
    }
    
    private func setupConstraints() {
        
        // Logo View
        
        let logoPadding: CGFloat = 50
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: logoPadding),
            logoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -logoPadding),
        ])
        
        // Input Form
        
        let formPadding: CGFloat = 30
        view.addSubview(inputFormContainer)
        inputFormContainer.translatesAutoresizingMaskIntoConstraints = false
        constraint = inputFormContainer.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 80)
        NSLayoutConstraint.activate([
            inputFormContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: formPadding),
            inputFormContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -formPadding),
            constraint,
        ])
    }
    
    private func setupLogoUI() {
        
        // Sign Button
        signContainerView.delegate = self
        view.addSubview(signContainerView)
        signContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signContainerView.topAnchor.constraint(equalTo: inputFormContainer.bottomAnchor, constant: 0),
            signContainerView.leadingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            signContainerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -28),
            signContainerView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension ViewController: SignButtonDelegate {
    func signUpTouched() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.constraint.constant = -80
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) {
            self.constraint.constant = 80
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
