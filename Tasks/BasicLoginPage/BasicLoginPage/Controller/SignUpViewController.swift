//
//  SignUpViewController.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/14.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    let titleLabel = UILabel()
    let inputForm = FormContainerView()
    let signUpButton = SignButton(type: .SignUp)
    let cancelButton = UIButton(type: .system)
    private func setupUI() {
        self.view.backgroundColor = .white
        
        titleLabel.text = "회원 가입"
        titleLabel.font = .boldSystemFont(ofSize: 48)
        
        signUpButton.setTitle("가입 완료", for: .normal)
        signUpButton.delegate = self
            
        inputForm.setTextFieldDelegate(self)
        
        cancelButton.setTitle(nil, for: .normal)
        if #available(iOS 13.0, *) {
            cancelButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        } else {
            cancelButton.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        }
        cancelButton.tintColor = .black
        cancelButton.addTarget(self, action: #selector(canceled(_:)), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let topPadding: CGFloat = 100
        let sidePadding: CGFloat = 48
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: sidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        view.addSubview(inputForm)
        inputForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputForm.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding / 2),
            inputForm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: sidePadding),
            inputForm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding),
        ])
        
        let buttonSidePadding: CGFloat = 24
        let buttonBottomPadding: CGFloat = 96
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: buttonSidePadding),
            signUpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -buttonSidePadding),
            signUpButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -buttonBottomPadding),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: 24),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: buttonSidePadding),
            cancelButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -buttonSidePadding
            )
        ])
    }
    
    @objc private func canceled(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- SignButtonDelegate

extension SignUpViewController: SignButtonDelegate {
    func signUpTouched() {
        guard inputForm.canSignUp(), let userInfo = inputForm.fetch() else {
            let alert = UIAlertController(title: "이메일을 확인하세요", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        UserDefaults.standard.set(userInfo.password, forKey: userInfo.email)
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
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
