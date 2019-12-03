//
//  SecondViewController.swift
//  [5-2]191203_StoryboardSegue
//
//  Created by cskim on 2019/12/03.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var textField: UITextField!
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = text
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        textField.keyboardType = .phonePad
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    var minus = 0
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        // sender.text == "5"
        if let number = Int(sender.text ?? "0") {
            minus = number
        }
    }
    
    @IBAction func unwindToSecondVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
