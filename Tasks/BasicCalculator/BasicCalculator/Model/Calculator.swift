//
//  Calculator.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class Calculator {
    
    enum Operator: String {
        case plus = "+", minus = "−", multiply = "×", divide = "÷", calculate = "="
        case none
        
        func operate(_ operand1: Double, _ operand2: Double) -> Double? {
            switch self {
            case .plus:
                return operand1 + operand2
            case .minus:
                return operand1 - operand2
            case .multiply:
                return operand1 * operand2
            case .divide:
                guard operand2 > 0 else { return nil }
                return operand1 / operand2
            case .calculate, .none:
                return nil
            }
        }
    }
    
    // MARK:- Properties
    
    private var firstOperator: Operator = .none {
        didSet {
            if secondOperator == .none {
                switch oldValue {
                case .plus, .minus, .multiply, .divide:
                    guard let first = firstOperand, secondOperand == nil,
                        firstOperator == .calculate, let calculation = oldValue.operate(first, first) else { return }
                    self.displayTitle = decimalFormat(from: calculation)
                    self.firstDisplay = ""
                    self.secondDisplay = ""
                    firstOperator = .calculate
                default:
                    return
                }
            }
        }
    }
    private var secondOperator: Operator = .none {
        didSet {
            if let first = firstOperand, let second = secondOperand,
                let calculation = firstOperator.operate(first, second)
            {
                self.firstDisplay = decimalFormat(from: calculation)
                self.secondDisplay = ""
                firstOperator = secondOperator
                secondOperator = .none
            }
        }
    }
    private var firstOperand: Double?
    private var firstDisplay = "" {
        didSet {
            if let number = Double(self.firstDisplay) {
                self.firstOperand = number
                self.displayTitle = decimalFormat(from: number)
            } else {
                self.firstOperand = nil
            }
        }
    }
    private var secondOperand: Double?
    private var secondDisplay = "" {
        didSet {
            if let number = Double(self.secondDisplay) {
                self.secondOperand = number
                self.displayTitle = decimalFormat(from: number)
            } else {
                self.secondOperand = nil
            }
        }
    }
    private var displayTitle: String = ""
    
    // MARK:- Update From Controller
    
    // 숫자 입력
    func update(operand number: Double) {
        switch firstOperator {
        case .none:
            guard firstDisplay.count < 13 else { return }
            firstDisplay += decimalFormat(from: number)
        case .calculate:
            firstOperator = .none
            firstDisplay = ""
            update(operand: number)
        default:
            guard secondDisplay.count < 13 else { return }
            secondDisplay += decimalFormat(from: number)
        }
    }
    
    // 연산자 입력
    func update(`operator`: String) {
        guard let currentOperator = Operator(rawValue: `operator`) else { return }
        if !firstDisplay.isEmpty && secondDisplay.isEmpty {
            firstOperator = currentOperator
        } else {
            secondOperator = currentOperator
        }
    }
    
    // All Clear
    func clear() {
        firstDisplay = ""
        secondDisplay = ""
        firstOperator = .none
        secondOperator = .none
        displayTitle = ""
    }
    
    // MARK:- Update to Controller
    
    // Display Text
    func display() -> String {
        return self.displayTitle.isEmpty ? "0" : self.displayTitle
    }
    
    // MARK:- Methods
    
    private func decimalFormat(from number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: number as NSNumber)!
    }
    
}
