//
//  ViewController.swift
//  [7-1]191216_DynamicAutoLayoutExample
//
//  Created by cskim on 2019/12/16.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var centerXConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        centerXConstraint.constant = 100
        
    }


}

