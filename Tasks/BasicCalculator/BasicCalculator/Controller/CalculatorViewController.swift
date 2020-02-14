//
//  CalculatorViewController.swift
//  CalculatorExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK:- Views
    
    let numberPad = NumberPadView()
    let display = DisplayLabel()
    let calcTitle = CalculatorTitle()
    
    // MARK:- Model
    
    let calculator = Calculator()

    // MARK:- Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        numberPad.setDelegate(self)
    }
    
    private func setupUI() {
        self.view.backgroundColor = CalculatorColor.background
        
        self.view.addSubview(self.numberPad)
        self.view.addSubview(self.display)
        display.text = "0"
        self.view.addSubview(calcTitle)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        
        let paddingX: CGFloat = 10
        let paddingY: CGFloat = 6
        numberPad.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberPad.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: paddingX),
            numberPad.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -paddingX),
            numberPad.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -paddingY),
            numberPad.widthAnchor.constraint(equalTo: numberPad.heightAnchor),
        ])
        
        let displayPaddingX: CGFloat = 20
        let displayPaddingY: CGFloat = 15
        display.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            display.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: displayPaddingX),
            display.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -displayPaddingX),
            display.bottomAnchor.constraint(equalTo: numberPad.topAnchor, constant: -displayPaddingY)
        ])
        
        calcTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calcTitle.topAnchor.constraint(equalTo: guide.topAnchor, constant: displayPaddingX),
            calcTitle.widthAnchor.constraint(equalTo: guide.widthAnchor),
        ])
    }

}

// MARK:- CalculatorButtonDelegate

extension CalculatorViewController: CalculatorButtonDelegate {
    func touched(_ sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "AC":
            calculator.clear()
        case let item where Int(item) != nil:
            calculator.update(operand: Double(item)!)
        case let op:
            calculator.update(operator: op)
        }
        display.text = calculator.display()
    }
}
