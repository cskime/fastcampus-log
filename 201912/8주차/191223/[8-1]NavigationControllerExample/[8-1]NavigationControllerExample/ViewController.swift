//
//  ViewController.swift
//  [8-1]NavigationControllerExample
//
//  Created by cskim on 2019/12/23.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let secondVC = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
//        show(secondVC, sender: nil)
        navigationController?.pushViewController(secondVC, animated: true)
        UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonItem.SystemItem#>, target: <#T##Any?#>, action: <#T##Selector?#>)
//        navigationItem.item
    }


}

