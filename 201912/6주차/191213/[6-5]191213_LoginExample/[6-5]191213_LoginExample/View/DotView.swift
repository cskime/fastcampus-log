//
//  DotView.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class DotView: UIStackView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let length: CGFloat = 24
    let padding: CGFloat = 24
    
    private func setupAttributes() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .center
        self.spacing = padding
    }
    
    private func setupUI() {
        for _ in 0...2 {
            let dot = Dot(length: length)
            self.addArrangedSubview(dot)
            
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: length).isActive = true
            dot.heightAnchor.constraint(equalToConstant: length).isActive = true
        }
    }

}
