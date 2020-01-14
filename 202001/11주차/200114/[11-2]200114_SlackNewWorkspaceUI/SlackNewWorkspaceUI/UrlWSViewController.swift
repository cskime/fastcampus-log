//
//  UrlWSViewController.swift
//  SlackNewWorkspaceUI
//
//  Created by giftbot on 2020/01/07.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class UrlWSViewController: UIViewController {
    var name: String?
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20)
        textField.returnKeyType = .go
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = .darkGray
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = ".slack.com"
        label.textColor = UIColor.placeholderText
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Get a URL (Letters, numbers, and dashes only)"
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.text = "This is the address that you'll use sign in to Slack."
        return label
    }()
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.alpha = 0.5
        label.text = "This URL is not available. Sorry!"
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.setupNavigationBar()
        self.setupAttributes()
        self.setupConstraints()
    }
    
    private func setupAttributes() {
        self.urlTextField.becomeFirstResponder()
        self.urlTextField.delegate = self
        self.urlTextField.text = self.name
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(previous(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(next(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .lightGray
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func previous(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private var isTextEntered = false
    @objc private func next(_ sender: UIBarButtonItem) {
        if !self.isTextEntered || self.urlTextField.text == "error" {
            self.vibrateTextField()
        }
    }
    
    private var textFieldLeading: NSLayoutConstraint!
    private var placeholderLeading: NSLayoutConstraint!
    private func setupConstraints() {
        [self.urlTextField,
         self.titleLabel,
         self.descriptionLabel,
         self.errorLabel,
         self.placeholderLabel].forEach { (view) in
            self.view.addSubview(view)
        }
        
        let guide = self.view.safeAreaLayoutGuide
        self.textFieldLeading = self.urlTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX)
        self.urlTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textFieldLeading,
            self.urlTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -UI.paddingX),
            self.urlTextField.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: -UI.centerYPadding),
        ])
        
        self.placeholderLeading = self.placeholderLabel.leadingAnchor.constraint(equalTo: self.urlTextField.leadingAnchor)
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeholderLeading,
            self.placeholderLabel.centerYAnchor.constraint(equalTo: self.urlTextField.centerYAnchor),
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.urlTextField.topAnchor, constant: -UI.spacing),
        ])
        
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.errorLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
            self.errorLabel.topAnchor.constraint(equalTo: self.urlTextField.bottomAnchor, constant: UI.spacing),
        ])
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: UI.centerYPadding / 2),
        ])
    }
    
    private func vibrateTextField() {
        self.errorLabel.isHidden = false
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

extension UrlWSViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isAvailable = !self.isTextEntered || textField.text == "error"
        if isAvailable { self.vibrateTextField() }
        return isAvailable
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text as NSString? else { return }
        let textWidth = inputText.size(withAttributes: [NSAttributedString.Key.font : textField.font!]).width
        self.placeholderLeading.constant = textWidth
        self.isTextEntered = (textWidth > 0)
        self.navigationItem.rightBarButtonItem?.tintColor = (textWidth == 0) ? UIColor.lightGray : UIColor.systemBlue
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textCount = textField.text?.count else { return false }
        self.errorLabel.isHidden = true
        return string.isEmpty || textCount < 20
    }
}
