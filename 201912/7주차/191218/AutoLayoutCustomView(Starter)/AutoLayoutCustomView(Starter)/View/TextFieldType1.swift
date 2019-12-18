//
//  TextFieldType1.swift
//  AutoLayoutCustomView(Starter)
//
//  Created by Lee on 2019/12/18.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

protocol TextFieldType1Delegate: class {
  func buttonDidTap(text: String?)
}

class TextFieldType1: UIView {
  
  weak var delegate: TextFieldType1Delegate?
  
  private let titleLabel = UILabel()
  private let textField = UITextField()
  private let guideLine = UIView()
  private let enterButton = UIButton()
  
  init(frame: CGRect, title: String, buttonTitle: String) {
    super.init(frame: frame)
    
    titleLabel.text = title
    enterButton.setTitle(buttonTitle, for: .normal)
    
    baseUI()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    titleLabel.numberOfLines = 0
    titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    self.addSubview(titleLabel)
    
    self.addSubview(textField)
    
    guideLine.backgroundColor = .black
    self.addSubview(guideLine)
    
    enterButton.setTitleColor(.white, for: .normal)
    enterButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    enterButton.layer.cornerRadius = 16
    enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    self.addSubview(enterButton)
  }
  
  private func autoLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.top),
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.xSpace),
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.xSpace),
    ])
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Standard.ySpace),
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.xSpace),
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.xSpace),
    ])
    
    guideLine.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        guideLine.heightAnchor.constraint(equalToConstant: 2),
        guideLine.topAnchor.constraint(equalTo: textField.bottomAnchor),
        guideLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
        guideLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
    ])
    
    enterButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        enterButton.topAnchor.constraint(equalTo: guideLine.bottomAnchor, constant: Standard.ySpace),
        enterButton.widthAnchor.constraint(equalToConstant: Standard.buttonWidth),
        enterButton.heightAnchor.constraint(equalToConstant: Standard.buttonHeight),
        enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        enterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  @objc private func enterButtonAction() {
    delegate?.buttonDidTap(text: textField.text)
  }
  
  private struct Standard {
    static let top: CGFloat = 80
    static let xSpace: CGFloat = 32
    static let ySpace: CGFloat = 24
    static let buttonWidth: CGFloat = 200
    static let buttonHeight: CGFloat = 40
  }
}
