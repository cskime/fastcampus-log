//
//  ViewController.swift
//  [6-2]191210_Homework
//
//  Created by cskim on 2019/12/10.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

protocol FirstViewControllerDelegate: class {
    func setText(_ text: String)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var delegateAButton: UIButton!
    @IBOutlet weak var delegateBButton: UIButton!
    weak var delegate: FirstViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func delegateTouched(_ sender: UIButton) {
        let secondVC = SecondViewController()
        if sender == delegateBButton {
            secondVC.delegate = self
            secondVC.touched = .delegateB
        }
        present(secondVC, animated: true)
        self.delegate?.setText(self.textField.text ?? "")
    }
    
    @IBAction func test(_ sender: Any) {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .automatic
        present(secondVC, animated: true)
    }
}

// MARK:- SecondViewControllerDelegate

extension ViewController: SecondViewControllerDelegate {
    func editedText() -> String {
        return textField.text ?? ""
    }
}

// MARK:- UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
