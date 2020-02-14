//
//  NumberPadView.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class NumberPadView: UIStackView {
    
    // MARK:- Initializer
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.axis = .vertical
        self.spacing = 8
        self.alignment = .fill
        self.distribution = .fillEqually
        self.setupComponents()
    }
    
    private func setupComponents() {
        
        /// Create NumberPad Buttons
        let stack1 = createHorizontalSet(items: ["1", "2", "3", "+"])
        let stack2 = createHorizontalSet(items: ["4", "5", "6", "−"])
        let stack3 = createHorizontalSet(items: ["7", "8", "9", "×"])
        let stack4 = createHorizontalSet(items: ["0", "AC", "=", "÷"])
        
        /// Merge Four Horizontal Stacks with Vertical Axis Stack
        for view in [stack1, stack2, stack3, stack4] {
            self.addArrangedSubview(view)
        }
    }
    
    private func createHorizontalSet(items: [String]) -> UIStackView {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        var color: UIColor
        for item in items {
            switch item {
            case "AC":
                color = CalculatorColor.allClear
            case let item where Int(item) == nil:
                color = CalculatorColor.operator
            default:
                color = CalculatorColor.number
            }
            let button = CalculatorButton(title: item, color: color)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    // MARK:- Methods
    
    func setDelegate(_ delegate: CalculatorButtonDelegate) {
        for horizontalStack in self.arrangedSubviews {
            for calcButton in (horizontalStack as! UIStackView).arrangedSubviews {
                (calcButton as! CalculatorButton).delegate = delegate
            }
        }
    }
}
