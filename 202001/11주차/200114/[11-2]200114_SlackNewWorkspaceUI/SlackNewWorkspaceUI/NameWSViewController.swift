//
//  NameWSViewController.swift
//  SlackNewWorkspaceUI
//
//  Created by giftbot on 2020/01/07.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

struct UI {
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
    static let centerYPadding: CGFloat = 180
}

struct Time {
    static let duration = 0.4
    static let vibrate = 0.4
}

final class NameWSViewController: UIViewController {
    
    private let placeholder = "Name your workspace"
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20)
        textField.returnKeyType = .go
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = .darkGray
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    private let animateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.setupNavigationBar()
        self.setupAttributes()
        self.setupConstraints()
    }
    
    private func setupAttributes() {
        self.activityIndicatorView.isHidden = true
        
        self.nameTextField.becomeFirstResponder()
        self.nameTextField.delegate = self
        self.nameTextField.placeholder = self.placeholder
        
        self.animateTitleLabel.text = self.placeholder
        self.animateTitleLabel.alpha = 0
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(exit(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(next(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private var bottomConstraint: NSLayoutConstraint!
    private var textFieldLeading: NSLayoutConstraint!
    private var indicatorLeading: NSLayoutConstraint!
    private func setupConstraints() {
        [self.nameTextField, self.animateTitleLabel, self.activityIndicatorView].forEach { (view) in
            self.view.addSubview(view)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        self.textFieldLeading = self.nameTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX)
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textFieldLeading,
            self.nameTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -UI.paddingX),
            self.nameTextField.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: -UI.centerYPadding),
        ])
        
        self.bottomConstraint = self.animateTitleLabel.bottomAnchor.constraint(equalTo: self.nameTextField.bottomAnchor)
        self.animateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.animateTitleLabel.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.bottomConstraint,
        ])
        
        self.indicatorLeading = self.activityIndicatorView.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.nameTextField.centerYAnchor),
            self.indicatorLeading,
        ])
    }
    
    @objc private func exit(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private var isTextEntered = false
    @objc private func next(_ sender: UIButton) {
        if self.isTextEntered {
            self.moveToUrlWSViewController()
        } else {
            self.vibrateTextField()
        }
    }
    
    private func moveToUrlWSViewController() {
        guard let inputText = self.nameTextField.text as NSString? else { return }
        let textWidth = inputText.size(withAttributes: [NSAttributedString.Key.font : self.nameTextField.font!]).width
        
        self.activityIndicatorView.isHidden = false
        self.indicatorLeading.constant = textWidth + 8
        self.activityIndicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicatorView.stopAnimating()
            let urlVC = UrlWSViewController()
            urlVC.name = self.nameTextField.text
            self.navigationController?.pushViewController(urlVC, animated: true)
        }
    }
    
    private func vibrateTextField() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        self.textFieldLeading.constant = UI.paddingX / 2
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: Time.vibrate,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0,
                       animations: {
                        self.textFieldLeading.constant = UI.paddingX
                        self.view.layoutIfNeeded()
        })
    }
}

// MARK:- UITextFieldDelegate

extension NameWSViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.isTextEntered {
            self.moveToUrlWSViewController()
        }
        return self.isTextEntered
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let currentText = textField.text else { return }
        self.isTextEntered = !currentText.isEmpty
        if self.isTextEntered {
            self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            self.showUpAnimation()
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
            self.hideAnimation()
        }
    }
    
    private func showUpAnimation() {
        UIView.animate(withDuration: Time.duration) {
            self.animateTitleLabel.alpha = 1
            self.bottomConstraint.constant = -self.nameTextField.frame.height - UI.spacing
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideAnimation() {
        UIView.animate(withDuration: Time.duration) {
            self.animateTitleLabel.alpha = 0
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
