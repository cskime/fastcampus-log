//
//  ViewController.swift
//  [4-1]191125_Homework
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    var count = 0
    let label = UILabel()
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50)
        label.text = "0"
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(presentTouched(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func presentTouched(_ sender: UIButton) {
        let bvc = BViewController()
        bvc.label.text = "\(count + 1)"
        count += 1
        self.present(bvc, animated: true)   // self : ViewController class
    }
}
