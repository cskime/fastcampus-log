
//
//  OrderDisplayLabel.swift
//  DominoStarter
//
//  Created by cskim on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class OrderDisplayLabel: UILabel {

    // MARK: Initialize
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.textColor = .white
        self.backgroundColor = Color.orderControl
        self.font = .systemFont(ofSize: 24)
        self.textAlignment = .center
    }
}
