//
//  OrderButton.swift
//  DominoStarter
//
//  Created by cskim on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

protocol OrderButtonDelegate: class {
    func order(_ sender: UIButton)
}

class OrderButton: UIButton {

    // MARK: Properties
    
    weak var delegate: OrderButtonDelegate?
    
    enum OrderType: String {
        case add = "+", subtract = "−"
    }
    var command: OrderType?
    
    // MARK: Initialize
    
    init(type: OrderButton.OrderType) {
        super.init(frame: .zero)
        self.setupUI(command: type)
        self.command = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(command: OrderButton.OrderType) {
        switch command {
        case .add:
            self.setTitle("+", for: .normal)
        case .subtract:
            self.setTitle("−", for: .normal)
        }
        self.titleLabel?.font = .systemFont(ofSize: 24)
        self.setTitleColor(.black, for: .normal)
        self.addTarget(self, action: #selector(touched(_:)), for: .touchUpInside)
        self.layer.borderWidth = 3
        self.layer.borderColor = Color.orderControl.cgColor
    }
    
    // MARK: Delegate Action
    
    @objc private func touched(_ sender: UIButton) {
        delegate?.order(sender)
    }

}
