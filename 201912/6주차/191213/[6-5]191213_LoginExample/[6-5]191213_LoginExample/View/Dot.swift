//
//  Dot.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class Dot: UIView {
    
    convenience init(length: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: length, height: length))
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI () {
        self.backgroundColor = UIColor(red: 218/255, green: 36/255, blue: 73/255, alpha: 1)
        self.layer.cornerRadius = self.frame.width / 4
    }
    
}
