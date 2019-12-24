//
//  DisplayLabel.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class DisplayLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.allowsDefaultTighteningForTruncation = true
        self.minimumScaleFactor = 0.5
        self.font = .systemFont(ofSize: 60, weight: .semibold)
        self.textAlignment = .right
        self.textColor = .white
    }
}
