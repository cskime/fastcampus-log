//
//  ViewController.swift
//  [10-2]Homework_UIGestureRecognizer
//
//  Created by cskim on 2020/01/07.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    private let countBase = "횟수 : "
    private let coordinateBase = "좌표 : "
    private var count = 0
    private var initialPoint = CGPoint(x: -10, y: -10)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private let shouldUseTouchesBegan = false
    private let shouldUseTapGesture = false
    private let shouldUseGestureDelegate = true
    
    // MARK: Touch Event를 이용하는 방법
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if shouldUseTouchesBegan {
            guard let touch = touches.first else { return }
            let location = touch.location(in: touch.view)

            let boundary = CGRect(x: self.initialPoint.x - 10, y: self.initialPoint.y - 10, width: 20, height: 20)
            if boundary.contains(location) {
                self.count += 1
            } else {
                self.count = 1
                self.initialPoint = location
            }

            countLabel.text = countBase + "\(self.count)"
            coordinateLabel.text = coordinateBase + "\(location)"
        }
    }
    
    // MARK: UIPanGestureRecognizer를 이용하는 방법
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        if shouldUseTapGesture {
            guard sender.state == .ended else { return }
            let location = sender.location(in: sender.view)
            
            let boundary = CGRect(x: self.initialPoint.x - 10, y: self.initialPoint.y - 10, width: 20, height: 20)
            if boundary.contains(location) {
                self.count += 1
            } else {
                self.count = 1
                self.initialPoint = location
            }
            
            countLabel.text = countBase + "\(self.count)"
            coordinateLabel.text = coordinateBase + "\(location)"
        }
    }
}

// MARK:- UIGestureRecognizerDelegate

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if shouldUseGestureDelegate {
            let location = touch.location(in: touch.view)
            
            let boundary = CGRect(x: self.initialPoint.x - 10, y: self.initialPoint.y - 10, width: 20, height: 20)
            if boundary.contains(location) {
                self.count += 1
            } else {
                self.count = 1
                self.initialPoint = location
            }
            
            countLabel.text = countBase + "\(self.count)"
            coordinateLabel.text = coordinateBase + "\(location)"
        }
        
        return true
    }
}

