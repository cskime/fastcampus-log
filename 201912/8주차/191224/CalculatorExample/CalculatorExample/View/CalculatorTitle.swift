//
//  CalculatorTitleLabel.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class CalculatorTitle: UILabel {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 35, weight: .bold)
        self.textColor = .white
        self.text = "Calculator"
    }
    
}
