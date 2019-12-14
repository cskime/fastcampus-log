//
//  FormContainerView.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class FormContainerView: UIView {

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        emailTextField.setTextFieldDelegate(delegate)
        passwordTextField.setTextFieldDelegate(delegate)
    }
    
    var emailTextField: FormTextField!
    var passwordTextField: FormTextField!
    private func setupUI() {
        
        emailTextField = FormTextField(placeholder: "이메일을 입력하세요", image: UIImage(named: ImageKey.email))
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: self.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        passwordTextField = FormTextField(placeholder: "비밀번호를 입력하세요", image: UIImage(named: ImageKey.password))
        passwordTextField.textField.isSecureTextEntry = true
        self.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    /// 회원 가입 가능한지 확인.
    /// 지금은 email 중복만 없으면 가능하지만 이후 다른 조건 붙을 수 있다
    func canSignUp() -> Bool {
        guard let emailInput = emailTextField.textField.text else { return false }
        guard emailInput.isEmpty == false else { return false }
        return UserDefaults.standard.string(forKey: emailInput) == nil
    }
    
    // 로그인 가능한지 확인
    func canSignIn() -> Bool {
        guard let emailInput = emailTextField.textField.text else {
            disaccordEffect(to: emailTextField)
            return false
        }
        
        guard let passwordInput = passwordTextField.textField.text else {
            disaccordEffect(to: passwordTextField)
            return false
        }
        
        guard let password = UserDefaults.standard.string(forKey: emailInput) else {
            disaccordEffect(to: emailTextField)
            return false
        }
        
        guard passwordInput == password else {
            disaccordEffect(to: passwordTextField)
            return false
        }
        
        return true
    }
    
    /// 입력된 email과 password를 가져옴
    func fetch() -> (email: String, password: String)? {
        guard
            let emailInput = emailTextField.textField.text,
            let passwordInput = passwordTextField.textField.text
        else { return nil }
        return (emailInput, passwordInput)
    }
    
    private func disaccordEffect(to textField: FormTextField?) {
        guard let textField = textField else { return }
        textField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        UIView.animate(withDuration: 0.7) {
            textField.backgroundColor = nil
        }
    }
}
