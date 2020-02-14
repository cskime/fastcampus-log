//
//  OrderControl.swift
//  DominoStarter
//
//  Created by cskim on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class OrderControl: UIStackView {

    // MARK: Initialize
    
    init() {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let addButton = OrderButton(type: .add)
    private let subButton = OrderButton(type: .subtract)
    private let displayLabel = OrderDisplayLabel()
    private func setupUI() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 0
        
        for view in [subButton, displayLabel, addButton] {
            self.addArrangedSubview(view)
        }
        
        self.setupConstraint()
    }
    
    private func setupConstraint() {
        let buttonSize = CGSize(width: 44, height: 40)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            addButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
        ])
        
        subButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subButton.widthAnchor.constraint(equalTo: addButton.widthAnchor),
            subButton.heightAnchor.constraint(equalTo: addButton.heightAnchor),
        ])
    }
    
    // MARK: Interface
    
    func setDelegate(_ delegate: OrderButtonDelegate) {
        addButton.delegate = delegate
        subButton.delegate = delegate
    }
    
    func updateDisplay(count: Int) {
        displayLabel.text = "\(count) 개"
    }
}
