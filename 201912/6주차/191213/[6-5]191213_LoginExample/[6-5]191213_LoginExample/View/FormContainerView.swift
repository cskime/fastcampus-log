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
        self.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
