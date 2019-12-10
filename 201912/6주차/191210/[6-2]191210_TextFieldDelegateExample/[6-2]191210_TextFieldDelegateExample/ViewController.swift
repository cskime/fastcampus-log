//
//  ViewController.swift
//  [6-2]191210_TextFieldDelegateExample
//
//  Created by cskim on 2019/12/10.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        presentationController?.delegate = self
    }
}

// MARK:- UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let colorStr = textField.text else { return false }
        
        var color: UIColor?
        switch colorStr {
        case "red":
            color = .red
        case "blue":
            color = .blue
        case "black":
            color = .black
        default:
            color = .gray
        }
        myView.backgroundColor = color
        
        // Return 터치하면 키보드 내려가도록
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // string : 새로 누른 값이 개별적으로 들어옴
        
        // true면 textField에 입력되고 false면 입력 안됨
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 입력 종료될 때
    }
}

// MARK:- UIAdaptivePresentationControllerDelegate

extension ViewController: UIAdaptivePresentationControllerDelegate {
    
}
