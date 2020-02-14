//
//  ViewController.swift
//  Ex1
//
//  Created by cskim on 2019/11/29.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- UI

    @IBOutlet weak var jjajangPriceLabel: UILabel!
    @IBOutlet weak var jjajangCountLabel: UILabel!
    @IBOutlet weak var jjambbongPriceLabel: UILabel!
    @IBOutlet weak var jjambbongCountLabel: UILabel!
    @IBOutlet weak var tangsuPriceLabel: UILabel!
    @IBOutlet weak var tangsuCountLabel: UILabel!

    var moneyDisplayLabel = UILabel()
    var paymentDisplayLabel = UILabel()

    // MARK:- Count & Price
        
    // MARK: Count
    
    var jjajangCount = 0 {
        didSet {
            jjajangCountLabel.text = "\(jjajangCount)"
            total = (jjajangCount != 0) ? total + jjajangPrice : total
        }
    }
    var jjambbongCount = 0 {
        didSet {
            jjambbongCountLabel.text = "\(jjambbongCount)"
            total = (jjambbongCount != 0) ? total + jjambbongPrice : total
        }
    }
    var tangsuCount = 0 {
        didSet {
            tangsuCountLabel.text = "\(tangsuCount)"
            total = (tangsuCount != 0) ? total + tangsuPrice : total
        }
    }
    
    // MARK: Price
    
    let jjajangPrice = 5000
    let jjambbongPrice = 6000
    let tangsuPrice = 12000
    let maxMoney = 70000
    
    /// 소지금
    var leftMoney = 70000 {
        didSet {
            moneyDisplayLabel.text = "\(leftMoney)원"
        }
    }
    /// 결제금액
    var total = 0 {
        didSet {
            paymentDisplayLabel.text = "\(total)원"
        }
    }
    
    // MARK:- Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingMenuUI()
        settingMoneyUI()
        settingPaymentUI()
    }
    
    /// Storyboard에서 만든 UI에서 금액을 초기화
    private func settingMenuUI() {
        jjajangPriceLabel.text = "\(jjajangPrice)원"
        jjambbongPriceLabel.text = "\(jjambbongPrice)원"
        tangsuPriceLabel.text = "\(tangsuPrice)원"
        leftMoney = maxMoney
    }
    
    /// Code 구현 UI : 소지금 레이블 및 초기화 버튼
    private func settingMoneyUI() {
        // Label
        let moneyLabel = UILabel()
        moneyLabel.frame = CGRect(x: 20,
                                  y: tangsuCountLabel.frame.maxY + 80,
                                  width: 80,
                                  height: 40)
        moneyLabel.text = "소지금"
        moneyLabel.textAlignment = .center
        moneyLabel.backgroundColor = .green
        view.addSubview(moneyLabel)
        
        // Display Money
        moneyDisplayLabel.frame = CGRect(x: moneyLabel.frame.maxX + 10,
                                         y: moneyLabel.frame.origin.y,
                                         width: 140,
                                         height: 40)
        moneyDisplayLabel.text = "\(maxMoney)원"
        moneyDisplayLabel.textAlignment = .right
        moneyDisplayLabel.backgroundColor = .green
        view.addSubview(moneyDisplayLabel)
        
        // Clear Payment Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: moneyDisplayLabel.frame.maxX + 20,
                              y: moneyDisplayLabel.frame.origin.y,
                              width: 80,
                              height: 40)
        button.setTitle("초기화", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        button.tintColor = .white
        view.addSubview(button)
    }
    
    /// Code 구현 UI : 결제금액 레이블 및 결제 버튼
    private func settingPaymentUI() {
        // Label
        let paymentLabel = UILabel()
        paymentLabel.frame = CGRect(x: 20,
                                    y: moneyDisplayLabel.frame.maxY + 10,
                                    width: 80,
                                    height: 40)
        paymentLabel.text = "결제금액"
        paymentLabel.textAlignment = .center
        paymentLabel.backgroundColor = .orange
        view.addSubview(paymentLabel)
        
        // Display Payment
        paymentDisplayLabel.frame = CGRect(x: paymentLabel.frame.maxX + 10,
                                           y: paymentLabel.frame.origin.y,
                                           width: 140,
                                           height: 40)
        paymentDisplayLabel.text = "0원"
        paymentDisplayLabel.textAlignment = .right
        paymentDisplayLabel.backgroundColor = .orange
        view.addSubview(paymentDisplayLabel)
        
        // Payment Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: paymentDisplayLabel.frame.maxX + 20,
                              y: paymentDisplayLabel.frame.origin.y,
                              width: 80,
                              height: 40)
        button.setTitle("결제", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(pay(_:)), for: .touchUpInside)
        button.backgroundColor = .black
        button.tintColor = .white
        view.addSubview(button)
    }
    
    /// 주문 수량 및 결제금액 초기화
    private func clearOrder() {
        jjajangCount = 0
        jjambbongCount = 0
        tangsuCount = 0
        total = 0
    }
    
    // MARK:- Actions
    
    @IBAction private func orderTouched(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            jjajangCount += 1
        case 1:
            jjambbongCount += 1
        case 2:
            tangsuCount += 1
        default:
            return
        }
    }
    
    @objc private func clear(_ sender: UIButton) {
        leftMoney = maxMoney
        clearOrder()
    }
    
    @objc private func pay(_ sender: UIButton) {
        var title = "", message = ""
        var actions = [UIAlertAction]()
        
        /// 결제 할 수 없는 경우 msg로 초기화
        func failPayment(msg: String) {
            title = "결제실패"
            message = msg
            let fail = UIAlertAction(title: "확인", style: .cancel)
            actions.append(fail)
        }
        
        /// 결제 가능한 경우 초기화
        func payment() {
            title = "결제하기"
            message = "총 결제금액은 \(total)원 입니다."
            let ok = UIAlertAction(title: "확인", style: .default) { (action) in
                self.leftMoney -= self.total
                self.clearOrder()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            actions.append(contentsOf: [ok, cancel])
        }
        
        if total == 0 {
            // 결제 금액이 없는 경우 주문 필요
            failPayment(msg: "먼저 주문을 해주세요")
        } else if leftMoney == 0 || leftMoney < total {
            // 소지 금액이 결제 금액보다 적은 경우 또는 0인 경우 결제 불가
            failPayment(msg: "소지 금액이 부족합니다.")
        } else {
            // 나머지 경우 결제 가능
            payment()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
}

