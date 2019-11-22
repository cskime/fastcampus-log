//
//  ViewController.swift
//  [3-5]191122_HomeworkApp
//
//  Created by cskim on 2019/11/22.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        `switch`.addTarget(self, action: #selector(valueSwitched(_:)), for: .valueChanged)
        segment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        onOffLabel.text = `switch`.isOn ? "On" : "Off"
        segmentLabel.text = segment.titleForSegment(at: segment.selectedSegmentIndex)
    }
    
    @objc func valueSwitched(_ sender: UISwitch) {
        onOffLabel.text = sender.isOn ? "On" : "Off"
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        segmentLabel.text = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }


}

