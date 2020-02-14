//
//  MainViewController.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private var signOutButton = SignButton(type: .SignOut)
    private var userLabel = UILabel()
    private func setupUI() {
        view.backgroundColor = .white
        
        signOutButton.delegate = self
        
        userLabel.text = UserDefaults.standard.string(forKey: UserInfoKey.loginedEmail)
        userLabel.font = .systemFont(ofSize: 24)
        userLabel.textAlignment = .center
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        let sidePadding: CGFloat = 24
        let bottomPadding: CGFloat = 96
        view.addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPadding),
            signOutButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: sidePadding),
            signOutButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -sidePadding),
            signOutButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        view.addSubview(userLabel)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            userLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            userLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

}

// MARK:- SignButtonDelegate

extension MainViewController: SignButtonDelegate {
    func signOutTouched() {
        if UserDefaults.standard.bool(forKey: UserInfoKey.isLogined) {
            UserDefaults.standard.set(false, forKey: UserInfoKey.isLogined)
            UserDefaults.standard.removeObject(forKey: UserInfoKey.loginedEmail)
            UserDefaults.standard.removeObject(forKey: UserInfoKey.loginedPassword)
        }
        
        if presentingViewController is SignInViewController {
            dismiss(animated: true, completion: nil)
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = SignInViewController()
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
