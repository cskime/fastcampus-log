//
//  SecondViewController.swift
//  [5-5]191206_Homework
//
//  Created by cskim on 2019/12/06.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var transferedLabel: UILabel!
    private var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }

    var isUseSingleton = true
    private func setupUI() {
        view.backgroundColor = .white
        
        transferedLabel = UILabel()
        transferedLabel.frame = CGRect(x: 0, y: view.frame.minY + 200, width: 200, height: 40)
        transferedLabel.center.x = view.center.x
        transferedLabel.text = isUseSingleton ? ViewController.shared.text : UserDefaults.standard.string(forKey: "InputText") ?? ""
        transferedLabel.textAlignment = .center
        view.addSubview(transferedLabel)
        
        dismissButton = UIButton(type: .system)
        dismissButton.frame = CGRect(x: 0, y: transferedLabel.frame.maxY + 100, width: 120, height: 40)
        dismissButton.center.x = view.center.x
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissTouched(_:)), for: .touchUpInside)
        view.addSubview(dismissButton)
    }
    
    @objc private func dismissTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
