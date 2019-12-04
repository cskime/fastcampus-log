//
//  ViewController.swift
//  [5-3]191204_CustomAlertController
//
//  Created by cskim on 2019/12/04.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var displayLabel: UILabel!

    var display = "Display" {
        didSet {
            displayLabel.text = display
        }
    }
    
    @IBAction private func alertTouched(_ sender: UIButton) {
        let myAlert = MyAlertController()
        myAlert.modalPresentationStyle = .overFullScreen
        present(myAlert, animated: true)
    }
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
        guard let alertVC = unwindSegue.source as? MyAlertController else { return }
        
        if alertVC.actionType == .enter {
            display = alertVC.input
        }
        alertVC.dismiss(animated: true, completion: nil)
    }
}

