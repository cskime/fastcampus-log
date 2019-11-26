//
//  ViewController.swift
//  [4-2]191126_Homework
//
//  Created by cskim on 2019/11/26.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    let textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 80)
        label.center = CGPoint(x: view.center.x, y: 200)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemRed
        label.text = ""
        view.addSubview(label)
        
        
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        textField.center = CGPoint(x: view.center.x, y: 250)
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.placeholder = "Input Text"
        textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndOnExit(_:)), for: .editingDidEndOnExit)
        view.addSubview(textField)
    }
    
    @objc func textFieldEditingDidBegin(_ sender: UITextField) {
        label.font = .systemFont(ofSize: 40)
        label.textColor = .systemBlue
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        label.text = sender.text
    }
    
    @objc func textFieldEditingDidEnd(_ sender: UITextField) {
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemRed
    }
    
    @objc func textFieldDidEndOnExit(_ sender: UITextField) {
        textFieldEditingDidEnd(sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

