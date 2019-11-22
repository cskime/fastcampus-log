//
//  ViewController.swift
//  [3-5]191122_Practice_ContentMode
//
//  Created by cskim on 2019/11/22.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageView = UIImageView(image: UIImage(named: "firecracker"))
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }


}

