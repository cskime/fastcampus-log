//
//  FormTextField.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class FormTextField: UIView {
    
    convenience init(placeholder: String, image: UIImage?) {
        self.init(frame: CGRect.zero)
        setupUI(placeholder: placeholder, image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
    
    let imageView = UIImageView()
    let textField = UITextField()
    let underline = UIView()
    
    private func setupUI(placeholder: String, image: UIImage?) {
        
        // Left Image
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        // Input TextField
        
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 20)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        
        // Underline
        
        underline.backgroundColor = .gray
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        // TextField
        
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        // Left Image
        
        let imageSize: CGFloat = 24
        let imagePadding: CGFloat = 16
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -imagePadding),
            imageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
        
        // Underline

        let textFieldPadding: CGFloat = 16
        self.addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldPadding),
            underline.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 1),
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
