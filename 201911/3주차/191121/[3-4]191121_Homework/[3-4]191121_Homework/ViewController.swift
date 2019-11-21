//
//  ViewController.swift
//  [3-4]191121_Homework
//
//  Created by cskim on 2019/11/21.
//  Copyright © 2019 cskim. All rights reserved.
//


/*
 - 스토리보드에서 객체 올리고 사용하기 : 버튼, 레이블
 - 스토리보드의 view controller와 클래스 연결
 - 레이블의 outlet 연결하기
 - 버튼의 outlet, action 연결하기
 */

import UIKit

class MyViewController: UIViewController {
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        plusButton.setTitle("PLUS", for: .normal)
        minusButton.setTitle("MINUS", for: .normal)
        
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        //        minusButton.addTarget(self, action: #selector(minusTouched(_:)), for: .touchUpInside)
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if sender == plusButton {
            count = count + 1
            stateLabel.text = "\(count)"
            stateLabel.textColor = .systemBlue
        } else {
            count -= 1
            stateLabel.text = "\(count)"
            stateLabel.textColor = .systemRed
        }
    }
    
    //    @objc func minusTouched(_ sender: UIButton) {
    //        print("Minus button touched")
    //        count -= 1
    //        stateLabel.text = "\(count)"
    //        stateLabel.textColor = .systemRed
    //    }
}

