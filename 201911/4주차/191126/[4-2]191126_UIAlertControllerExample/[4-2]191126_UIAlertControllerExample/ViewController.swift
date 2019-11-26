//
//  ViewController.swift
//  [4-2]191126_UIAlertControllerExample
//
//  Created by cskim on 2019/11/26.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0 {
        didSet {
            label.text = "\(count)"
        }
    }
    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .contactAdd)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        label.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.text = "\(count)"
        view.addSubview(label)
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        let alert = UIAlertController(title: "카운트 추가", message: "", preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Add Number" }
        
        let add = UIAlertAction(title: "Add Count", style: .default) { _ in
            guard let text = alert.textFields?[0].text, let number = Int(text) else { return }
            self.count += number
        }
        let reset = UIAlertAction(title: "Reset", style: .destructive) { _ in
            self.count = 0
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        for action in [add, reset, cancel] {
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
}

