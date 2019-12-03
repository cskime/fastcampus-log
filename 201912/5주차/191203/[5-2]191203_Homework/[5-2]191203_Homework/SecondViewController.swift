//
//  SecondViewController.swift
//  [5-2]191203_Homework
//
//  Created by cskim on 2019/12/03.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: name)
    }
    
    var count = 0
    @IBAction private func countTouched(_ sender: UIButton) {
        count += 1
    }
}
