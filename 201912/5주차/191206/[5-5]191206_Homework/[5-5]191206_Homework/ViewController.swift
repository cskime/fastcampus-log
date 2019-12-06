//
//  ViewController.swift
//  [5-5]191206_Homework
//
//  Created by cskim on 2019/12/06.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var textField: UITextField!
    private var userDefaultButton: UIButton!
    private var singletonButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }

    private func setupUI() {
        textField = UITextField()
        textField.frame = CGRect(x: 0, y: view.frame.minY + 150, width: view.frame.width * 0.8, height: 40)
        textField.center.x = view.center.x
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidEndOnExit(_:)), for: .editingDidEndOnExit)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        view.addSubview(textField)
        
        userDefaultButton = UIButton(type: .system)
        userDefaultButton.frame = CGRect(x: 0, y: textField.frame.maxY + 200, width: 120, height: 40)
        userDefaultButton.center.x = view.center.x
        userDefaultButton.setTitle("User Defaults", for: .normal)
        userDefaultButton.addTarget(self, action: #selector(transfer(_:)), for: .touchUpInside)
        view.addSubview(userDefaultButton)
        
        singletonButton = UIButton(type: .system)
        singletonButton.frame = CGRect(x: 0, y: userDefaultButton.frame.maxY + 50, width: 120, height: 40)
        singletonButton.center.x = view.center.x
        singletonButton.setTitle("Singleton", for: .normal)
        singletonButton.addTarget(self, action: #selector(transfer(_:)), for: .touchUpInside)
        view.addSubview(singletonButton)
    }
    
    var text = ""
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        self.text = sender.text ?? ""
    }
    
    @objc private func textFieldDidEndOnExit(_ sender: UITextField) { }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    static let shared = ViewController()
    @objc private func transfer(_ sender: UIButton) {
        let secondVC = SecondViewController()
        secondVC.isUseSingleton = (sender != userDefaultButton)
        
        if secondVC.isUseSingleton {
            ViewController.shared.text = self.text
        } else {
            UserDefaults.standard.set(text, forKey: "InputText")
        }
        
        present(secondVC, animated: true, completion: nil)
    }

}

