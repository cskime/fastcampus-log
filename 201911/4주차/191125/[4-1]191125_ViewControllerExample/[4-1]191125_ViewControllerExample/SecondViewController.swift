//
//  NextViewController.swift
//  [4-1]191125_ViewControllerExample
//
//  Created by cskim on 2019/11/25.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Next View Did Load")
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
//            isModalInPresentation = true
        } else {
            view.backgroundColor = .white
        }
        presentationController?.delegate = self
        
        setupUI()
    }
    
    let button = UIButton(type: .system)
    
    func setupUI() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.center = CGPoint(x: view.frame.width / 4, y: view.center.y)
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(presentTouched), for: .touchUpInside)
        view.addSubview(button)
        
        let dismissButton = UIButton(type: .system)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        dismissButton.center = CGPoint(x: view.frame.width * 3 / 4 , y: view.center.y)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissTouched), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        label.font = .systemFont(ofSize: 30)
        label.text = "Second View"
        label.textAlignment = .center
        label.center = CGPoint(x: view.center.x, y: view.center.y / 3)
        view.addSubview(label)
    }
    
    @objc func presentTouched(_ sender: UIButton) {
        let thirdVC = ThirdViewController()
        if #available(iOS 13.0, *) {
            thirdVC.modalPresentationStyle = .automatic
        } else {
            thirdVC.modalPresentationStyle = .fullScreen
        }
        present(thirdVC, animated: true)
    }
    
    @objc func dismissTouched(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before appearing the view.
        print("Next View Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        print("Next View Did Appear")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Next View Will Disappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Next View Did Disappear")
        
    }
}

extension SecondViewController: UIAdaptivePresentationControllerDelegate {
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
