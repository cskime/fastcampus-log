//
//  ViewController.swift
//  [4-1]191125_ViewControllerExample
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View Did Load")
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        setupUI()
    }
    
    func setupUI() {
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.center = view.center
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        label.font = .systemFont(ofSize: 30)
        label.text = "First View"
        label.textAlignment = .center
        label.center = CGPoint(x: view.center.x, y: view.center.y / 3)
        view.addSubview(label)
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        let nextVC = SecondViewController()
        if #available(iOS 13.0, *) {
            nextVC.modalPresentationStyle = .automatic
        } else {
            nextVC.modalPresentationStyle = .fullScreen
        }
        
//        nextVC.view.backgroundColor = .green
        present(nextVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before appearing the view.
        print("View Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        print("View Did Appear")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View Will Disappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View Did Disappear")
        
    }
}

// 원래 있었지만 잘 쓰지 않았음
// ios 13에서 추가된 함수들이 카드 형식에서 드래그 제스처를 사용할 때 호출되는 함수를 사용
extension FirstViewController: UIAdaptivePresentationControllerDelegate {
    // 호출되는 경우
    // 1. isModalInPresentation = true일 때
    // 2. shouldDismiss가 false를 반환할 때
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("Dismiss Gesture: didAttemptToDismiss")
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        print("Dismiss Gesture: shouldDismiss")
        return true
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        print("Dismiss Gesture: willDismiss")
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("Dismiss Gesture: didDismiss")
    }
}
