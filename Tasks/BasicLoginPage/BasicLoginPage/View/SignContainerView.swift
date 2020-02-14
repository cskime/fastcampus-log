//
//  SignContainerView.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SignContainerView: UIView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let signInButton = SignButton(type: .SignIn)
    let signUpButton = SignButton(type: .SignUp)
    private func setupConstraints() {
        self.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: self.topAnchor),
            signInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 12),
            signUpButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func setButtonDelegate(_ delegate: SignButtonDelegate) {
        signInButton.delegate = delegate
        signUpButton.delegate = delegate
    }
}
