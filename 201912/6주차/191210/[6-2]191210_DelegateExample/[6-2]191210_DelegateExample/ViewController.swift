//
//  ViewController.swift
//  [6-2]191210_DelegateExample
//
//  Created by cskim on 2019/12/10.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myView.delegate = self
        myView.backgroundColor = .red
        
    }


}

extension ViewController: CustomViewDelegate {
    func controlColor(newColor newValue: UIColor?) -> UIColor? {
        guard let color = newValue else { return .gray }
        return color == .red ? .blue : color
    }
}

