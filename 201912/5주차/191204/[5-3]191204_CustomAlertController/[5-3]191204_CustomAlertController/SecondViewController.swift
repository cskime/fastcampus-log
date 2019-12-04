//
//  SecondViewController.swift
//  [5-3]191204_CustomAlertController
//
//  Created by cskim on 2019/12/04.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

enum ActionType {
    case cancel
    case enter
}

class MyAlertController: UIViewController {
    private var baseView = UIView()
    private var titleLabel = UILabel()
    private var messageLabel = UILabel()
    private var textField = UITextField()
    private var cancelButton = UIButton()
    private var enterButton = UIButton()
    
    var actionType = ActionType.cancel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        baseUI()
    }
    
    private func baseUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let baseWidth = view.frame.width - 100
        let baseHeight: CGFloat = 200
        let itemHeight:CGFloat = 50
        let textFieldSpace = CGFloat(20)
        
        // Base View
        baseView.backgroundColor = .secondarySystemBackground
        baseView.frame.size = CGSize(width: baseWidth, height: baseHeight)
        baseView.center = view.center
        baseView.layer.cornerRadius = 15
        view.addSubview(baseView)
        
        // Title Label
        titleLabel.text = "Title"
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: baseWidth, height: itemHeight)
        baseView.addSubview(titleLabel)
        
        messageLabel.text = "Message"
        messageLabel.textAlignment = .center
        messageLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY, width: baseWidth, height: itemHeight)
        baseView.addSubview(messageLabel)
        
//        textField.becomeFirstResponder()
        textField.frame = CGRect(
            x: textFieldSpace,
            y: messageLabel.frame.maxY,
            width: baseWidth - (textFieldSpace * 2),
            height: itemHeight
        )
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndOnExit(_:)), for: .editingDidEndOnExit)
        baseView.addSubview(textField)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.frame = CGRect(
            x: 0,
            y: textField.frame.maxY,
            width: baseWidth / 2,
            height: itemHeight
        )
        cancelButton.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        baseView.addSubview(cancelButton)
        
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(.blue, for: .normal)
        enterButton.frame = CGRect(
            x: cancelButton.frame.maxX,
            y: textField.frame.maxY,
            width: baseWidth / 2,
            height: itemHeight
        )
        enterButton.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        baseView.addSubview(enterButton)
    }
    
    @IBAction private func buttonTouched(_ sender: UIButton) {
//        if sender == enterButton {
//            guard let first = presentingViewController as? ViewController else { return }
//
//            first.display = input
//        }
//        dismiss(animated: true, completion: nil)
    }
    
    var input = ""
    @IBAction private func textFieldEditingChanged(_ sender: UITextField) {
        input = sender.text ?? ""
    }
    
    @objc private func textFieldDidEndOnExit(_ sender: UITextField) {
        print("입력")
    }
}
