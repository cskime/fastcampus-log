//
//  SignContainerView.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

protocol SignButtonDelegate: class {
    func signUpTouched()
}


class SignContainerView: UIView {

    weak var delegate: SignButtonDelegate?
    
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
    
    private func setupUI() {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(signTouched(_:)), for: .touchUpInside)
        button.backgroundColor = .gray
        button.tintColor = .white
        button.layer.cornerRadius = 10
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc func signTouched(_ sender: UIButton) {
        delegate?.signUpTouched()
    }

}
