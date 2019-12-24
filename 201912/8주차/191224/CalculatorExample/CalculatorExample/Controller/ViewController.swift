//
//  ViewController.swift
//  CalculatorExample
//
//  Created by giftbot on 2019/12/19.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK:- Outlets
    
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var calcButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK:- Calculator Properties
    
    private enum Operator: Int {
        case plus, minus, multiply, divide, calculate, none
        
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
    
    private var firstOperator: Operator = .none {
        didSet {
            if secondOperator == .none {
                switch oldValue {
                case .plus, .minus, .multiply, .divide:
                    guard let left = leftOperand, rightOperand == nil,
                        firstOperator == .calculate, let calculation = oldValue.operate(left, left) else { return }
                    self.displayText = "\(decimalFormat(from: calculation))"
                    self.displayLeft = ""
                    self.displayRight = ""
                    firstOperator = .calculate
                default:
                    return
                }
            }
        }
    }
    private var secondOperator: Operator = .none {
        didSet {
            if let left = leftOperand, let right = rightOperand,
                let calculation = firstOperator.operate(left, right)
            {
                self.displayLeft = "\(decimalFormat(from: calculation))"
                self.displayRight = ""
                firstOperator = secondOperator
                secondOperator = .none
            }
        }
    }
    
    private var leftOperand: Double?
    private var displayLeft: String = "" {
        didSet {
            if let number = Double(self.displayLeft) {
                self.leftOperand = number
                self.displayText = decimalFormat(from: number)
            } else {
                self.leftOperand = nil
            }
        }
    }
    
    private var rightOperand: Double?
    private var displayRight: String = "" {
        didSet {
            if let number = Double(self.displayRight) {
                rightOperand = number
                self.displayText = decimalFormat(from: number)
            } else {
                rightOperand = nil
            }
        }
    }
    
    private var displayText: String = "0" {
        didSet {
            self.displayLabel.text = displayText
        }
    }
    
    // MARK:- View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButton()
    }    
    
    private func roundButton() {
        for button in numberButtons {
            button.layer.cornerRadius = button.frame.width / 2
        }
        
        var tag = 0
        for button in calcButtons {
            button.tag = tag
            button.layer.cornerRadius = button.frame.width / 2
            tag += 1
        }
        
        clearButton.layer.cornerRadius = clearButton.frame.width / 2
    }
    
    // MARK:- Methods
    
    private func decimalFormat(from number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: number as NSNumber)!
    }
    
    // MARK:- Actions
    
    @IBAction func numberTouched(_ sender: UIButton) {
        switch firstOperator {
        case .none:
            guard displayLeft.count < 13 else { return }
            displayLeft += sender.titleLabel!.text!
        case .calculate:
            firstOperator = .none
            displayLeft = ""
            numberTouched(sender)
        default:
            guard displayRight.count < 13 else { return }
            displayRight += sender.titleLabel!.text!
        }
    }
    
    private func clear() {
        displayText = "0"
        displayLeft = ""
        displayRight = ""
        firstOperator = .none
        secondOperator = .none
    }
    
    @IBAction func clearTouched(_ sender: UIButton) {
        clear()
    }
    
    @IBAction func calcTouched(_ sender: UIButton) {
        guard let currentOperator = Operator(rawValue: sender.tag) else { return }
        if !displayLeft.isEmpty && displayRight.isEmpty {
            firstOperator = currentOperator
        } else {
            secondOperator = currentOperator
        }
    }
}
