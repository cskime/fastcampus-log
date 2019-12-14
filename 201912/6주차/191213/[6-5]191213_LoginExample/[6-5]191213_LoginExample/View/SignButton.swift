//
//  SignButton.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/14.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

@objc protocol SignButtonDelegate: class {
    @objc optional func signUpTouched()
    @objc optional func signInTouched()
    @objc optional func signOutTouched()
}

class SignButton: UIButton {

    weak var delegate: SignButtonDelegate?
    
    enum SignType {
        case SignIn
        case SignUp
        case SignOut
    }
    private var signType: SignType = .SignIn
    
    convenience init(type: SignType) {
        self.init(frame: CGRect.zero)
        self.signType = type
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        switch self.signType {
        case .SignIn:
            self.setTitle("Sign In", for: .normal)
        case .SignUp:
            self.setTitle("Sign Up", for: .normal)
        case .SignOut:
            self.setTitle("Sign Out", for: .normal)
        }
        self.addTarget(self, action: #selector(signTouched(_:)), for: .touchUpInside)
        
        self.titleLabel?.font = .systemFont(ofSize: 24)
        self.backgroundColor = .gray
        self.tintColor = .white
        self.layer.cornerRadius = 10
    }
    
    @objc func signTouched(_ sender: SignButton) {
        switch self.signType {
        case .SignIn:
            delegate?.signInTouched?()
        case .SignUp:
            delegate?.signUpTouched?()
        case .SignOut:
            delegate?.signOutTouched?()
        }
    }
}
