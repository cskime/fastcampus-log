//
//  SecondViewController.swift
//  [6-2]191210_Homework
//
//  Created by cskim on 2019/12/10.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

enum Delegation {
    case delegateA
    case delegateB
}

protocol SecondViewControllerDelegate: class {
    func editedText() -> String
}

class SecondViewController: UIViewController {

    private var label = UILabel()
    private var button = UIButton(type: .system)
    weak var delegate: SecondViewControllerDelegate?
    
    var touched = Delegation.delegateA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        switch touched {
        case .delegateA:
            print("Delegation A")
            guard let firstVC = presentingViewController as? ViewController else { return }
            firstVC.delegate = self
        case .delegateB:
            print("Delegation B")
            self.label.text = self.delegate?.editedText()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before appearing the view.
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        label.frame = CGRect(x: 0, y: 150, width: 200, height: 40)
        label.center.x = self.view.center.x
        label.textAlignment = .center
        self.view.addSubview(label)
        
        button.frame = CGRect(x: 0, y: label.frame.maxY + 100, width: 80, height: 40)
        button.center.x = self.view.center.x
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissTouched(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc private func dismissTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- AViewControllerDelegate

extension SecondViewController: FirstViewControllerDelegate {
    func setText(_ text: String) {
        self.label.text = text
    }
}
