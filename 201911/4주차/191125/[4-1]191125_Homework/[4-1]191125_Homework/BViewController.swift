//
//  BViewController.swift
//  [4-1]191125_Homework
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    var count = 0
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        guard let presentingViewController = presentingViewController as? ViewController else {
            return
        }
        label.text = "\(presentingViewController.count)"
    }
    
    let label = UILabel()
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50)
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        button.setTitle("Dismiss", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(dismissTouched(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func dismissTouched(_ sender: UIButton) {
        guard let aViewController = presentingViewController as? ViewController else {
            return
        }
        count += 1
        aViewController.count += count
        aViewController.label.text = "\(aViewController.count)"
        dismiss(animated: true)
    }
}
