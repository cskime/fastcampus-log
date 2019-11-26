//
//  ViewController.swift
//  [4-2]191126_UITextFieldExample
//
//  Created by cskim on 2019/11/26.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var comfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        loginTextField.becomeFirstResponder()
        loginTextField.font = .preferredFont(forTextStyle: .)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        
        if sender.tag == 1 {
            print("Login TextField: Did End On Exit")
        } else if sender.tag == 2 {
            print("Password TextField: Did End On Exit")
        } else {
            print("Confirm TextField: Did End On Exit")
        }
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        
        if sender.tag == 1 {
            print("Login TextField: Editing Did Begin")
        } else if sender.tag == 2 {
            print("Password TextField: Editing Did Begin")
        } else {
            print("Confirm TextField: Editing Did Begin")
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        
        if sender.tag == 1 {
            print("Login TextField: Editing Changed")
        } else if sender.tag == 2 {
            print("Password TextField: Editing Changed")
        } else {
            print("Confirm TextField: Editing Changed")
        }
        
        if sender.text!.count == 6 {
            sender.resignFirstResponder()
        }
        
        view.endEditing(<#T##force: Bool##Bool#>)
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        
        if sender.tag == 1 {
            print("Login TextField: Editing Did End")
        } else if sender.tag == 2 {
            print("Password TextField: Editing Did End")
        } else {
            print("Confirm TextField: Editing Did End")
        }
    }
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        guard let sender = sender as? UITextField else { return }
        
        if sender == loginTextField {
            print("Login TextField: Primary Action Trigerred")
            sender.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            
        } else if sender.tag == 2 {
            print("Password TextField: Primary Action Trigerred")
        } else {
            print("Confirm TextField: Primary Action Trigerred")
        }
    }
}

