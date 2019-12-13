//
//  MainViewController.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var dismissButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setupUI()
    }
    

    private func setupUI() {
        view.backgroundColor = .white
        
        dismissButton.frame.size = CGSize(width: 80, height: 40)
        dismissButton.addTarget(self, action: #selector(dismissTouched(_:)), for: .touchUpInside)
        dismissButton.center = view.center
        dismissButton.setTitle("Dismiss", for: .normal)
        view.addSubview(dismissButton)
    }
    
    @objc func dismissTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
