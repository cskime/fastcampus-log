//
//  ViewController.swift
//  [5-5]191206_Practice
//
//  Created by cskim on 2019/12/06.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var imageView: UIImageView!
    private var changeSwitch: UISwitch!
    private var nameLabel: UILabel!
    
    private var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    private var name: String = "Label" {
        didSet {
            nameLabel.text = name
        }
    }
    private var isSwitchOn: Bool = true {
        didSet {
            changeSwitch.isOn = isSwitchOn
            self.name = isSwitchOn ? "Cat" : "Dog"
            self.image = isSwitchOn ? UIImage(named: "cat") : UIImage(named: "dog")
        }
    }
    
    struct Key {
        static let image = "Image"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    private func setupUI() {
        imageView = UIImageView()
        imageView.frame = CGRect(x:0, y: 150, width: view.frame.width * 0.8, height: 200)
        imageView.center.x = view.center.x
        
        view.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 10, width: 200, height: 50)
        nameLabel.center.x = view.center.x
        nameLabel.textAlignment = .center
        
        view.addSubview(nameLabel)
        
        changeSwitch = UISwitch()
        changeSwitch.frame = CGRect(x: 0, y: nameLabel.frame.maxY + 50, width: 80, height: 40)
        changeSwitch.center.x = self.view.center.x
        changeSwitch.addTarget(self, action: #selector(switchTouched(_:)), for: .valueChanged)
        view.addSubview(changeSwitch)
        
        let picker = UserDefaults.standard.bool(forKey: Key.image)
        nameLabel.text = picker ? "Cat" : "Dog"
        imageView.image = picker ? UIImage(named: "cat") : UIImage(named: "dog")
    }

    @objc private func switchTouched(_ sender: UISwitch) {
        self.isSwitchOn = sender.isOn
        UserDefaults.standard.set(self.isSwitchOn, forKey: Key.image)
    }
}

