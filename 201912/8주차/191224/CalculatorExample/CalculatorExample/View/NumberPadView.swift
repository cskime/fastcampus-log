//
//  NumberPadView.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class NumberPadView: UIView {
    
    // MARK:- Properties
    
    private var stack1: UIStackView!
    private var stack2: UIStackView!
    private var stack3: UIStackView!
    private var stack4: UIStackView!
    private let spacing: CGFloat = 8
    
    // MARK:- Methods
    
    private func mergeSubviews(_ subviews: [UIView]...) -> [UIView] {
        var result = [UIView]()
        for array in subviews {
            result += array
        }
        return result
    }
    
    func setDelegate(_ delegate: CalculatorButtonDelegate) {
        let subviews = mergeSubviews(stack1.arrangedSubviews,
                                     stack2.arrangedSubviews,
                                     stack3.arrangedSubviews,
                                     stack4.arrangedSubviews)
        for subview in subviews {
            (subview as! CalculatorButton).delegate = delegate
        }
    }
    
    // MARK:- Initializer
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStackView(items: [String]) -> UIStackView {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
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
    
    private func setupUI() {
        
        stack1 = createStackView(items: ["1", "2", "3", "+"])
        stack2 = createStackView(items: ["4", "5", "6", "−"])
        stack3 = createStackView(items: ["7", "8", "9", "×"])
        stack4 = createStackView(items: ["0", "AC", "=", "÷"])
        
        setupConstraint()
    }
    
    private func setupConstraint() {
    
        stack1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack1.topAnchor.constraint(equalTo: self.topAnchor),
            stack1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        stack2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack2.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: self.spacing),
            stack2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack3.topAnchor.constraint(equalTo: stack2.bottomAnchor, constant: self.spacing),
            stack3.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack3.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        stack4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack4.topAnchor.constraint(equalTo: stack3.bottomAnchor, constant: spacing),
            stack4.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack4.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack4.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
