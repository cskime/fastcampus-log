//
//  ThirdViewController.swift
//  [4-1]191125_ViewControllerExample
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setupUI()
    }
    
    func setupUI() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.center = CGPoint(x: view.frame.width / 4, y: view.center.y)
        button.setTitle("Dismiss All", for: .normal)
        button.addTarget(self, action: #selector(dismissATouched), for: .touchUpInside)
        view.addSubview(button)
        
        let dismissButton = UIButton(type: .system)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        dismissButton.center = CGPoint(x: view.frame.width * 3 / 4 , y: view.center.y)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissBTouched), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        label.font = .systemFont(ofSize: 30)
        label.text = "Third View"
        label.textAlignment = .center
        label.center = CGPoint(x: view.center.x, y: view.center.y / 3)
        view.addSubview(label)
    }
    
    @objc func dismissATouched(_ sender: UIButton) {
        let nextVC = ThirdViewController()
        if #available(iOS 13.0, *) {
            nextVC.modalPresentationStyle = .fullScreen
        } else {
            nextVC.modalPresentationStyle = .fullScreen
        }
        // First로 한번에 이동
        // First - Second - Third
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func dismissBTouched(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
