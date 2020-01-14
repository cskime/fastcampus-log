//
//  ViewController.swift
//  [11-1]200113_UIViewAnimationPractice
//
//  Created by cskim on 2020/01/13.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let buttonSize: CGFloat = 50
    private let buttonSpacing: CGFloat = 100
    private var leftButtons = [UIButton]()
    private var rightButtons = [UIButton]()
    private let scaleTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    private let buttonCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0..<buttonCount {
            let button = createButton(tag: index)
            button.center.x = self.buttonSize * 1.5
            button.center.y = self.view.frame.maxY - self.buttonSize * 1.5
            if index != 0 { button.transform = scaleTransform }
            leftButtons.append(button)
            self.view.insertSubview(button, at: 0)
        }
        
        var tempView: UIView = self.view
        for index in 0..<buttonCount {
            let button = createButton(tag: index + 10)
            if index == 0 {
                button.center.x = self.view.frame.maxX - self.buttonSize * 1.5
                button.center.y = self.view.frame.maxY - self.buttonSize * 1.5
                self.view.addSubview(button)
            } else if index == 1 {
                button.center.x = self.view.frame.maxX - self.buttonSize * 1.5
                button.center.y = self.view.frame.maxY - self.buttonSize * 1.5
                self.view.insertSubview(button, at: 0)
                tempView = button
            } else {
                tempView.addSubview(button)
                tempView = button
            }
            
            if index != 0 { button.transform = self.scaleTransform }
            rightButtons.append(button)
        }
    }
    
    var randomColorScheme: CGFloat {
        get { return CGFloat((0...255).randomElement()!) / 255 }
    }
    func createButton(tag: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0,
                                            width: self.buttonSize,
                                            height: self.buttonSize))
        button.layer.cornerRadius = button.frame.width / 2
        button.backgroundColor = UIColor(red: randomColorScheme, green: randomColorScheme, blue: randomColorScheme, alpha: 1.0)
        
        button.tag = tag
        button.setTitle("버튼 \(tag % 10)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        return button
    }
    
    private var shouldSpreadLeft = true
    @objc private func buttonTouched(_ sender: UIButton) {
        if sender.tag == 0 {
            self.animationLeft()
        } else if sender.tag == 10 {
            self.animationRight()
        }
        print("Tag :", sender.tag)
    }
    
    private func animationLeft() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations:
            {
                self.leftButtons.forEach { (button) in
                    if self.shouldSpreadLeft {
                        if button.tag != 0 { button.transform = .identity }
                        button.center.y -= self.buttonSpacing * CGFloat(button.tag)
                    } else {
                        if button.tag != 0 { button.transform = self.scaleTransform }
                        button.center.y += self.buttonSpacing * CGFloat(button.tag)
                    }
                }
                self.shouldSpreadLeft.toggle()
        })
    }
    
    private var shouldSpreadRight = true
    private func animationRight() {
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: [.beginFromCurrentState],
                                animations:
            {
                if self.shouldSpreadRight {
                    self.rightButtons.forEach { (button) in
                        if button.tag != 10 {
                            UIView.addKeyframe(withRelativeStartTime: 0.25 * Double(button.tag - 11), relativeDuration: 0.25) {
                                button.transform = .identity
                                button.center.y -= self.buttonSpacing
                            }
                        }
                    }
                } else {
                    self.rightButtons.reversed().forEach { (button) in
                        if button.tag != 10 {
                            UIView.addKeyframe(withRelativeStartTime: 0.25 * Double(14 - button.tag), relativeDuration: 0.25) {
                                button.transform = self.scaleTransform
                                button.center.y += self.buttonSpacing
                            }
                        }
                    }
                }
                self.shouldSpreadRight.toggle()
        })
    }
}

