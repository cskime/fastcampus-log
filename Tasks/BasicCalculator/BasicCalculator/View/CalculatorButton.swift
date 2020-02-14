//
//  NumberButton.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

protocol CalculatorButtonDelegate: class {
    func touched(_ sender: UIButton)
}

final class CalculatorButton: UIButton {
    
    weak var delegate: CalculatorButtonDelegate?
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        setupUI(title: title, color: color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }

    private func setupUI(title: String, color: UIColor) {
        self.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.titleLabel?.font = .systemFont(ofSize: 40)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    @objc private func buttonTouched(_ sender: UIButton) {
        delegate?.touched(sender)
    }
}
