//
//  ViewController.swift
//  [6-4]191212_AutoLayoutExample
//
//  Created by cskim on 2019/12/12.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class MyView: UIView {
    override func layoutSubviews() {
        
        print("View Layout Subviews :", self.safeAreaInsets)
        super.layoutSubviews()
    }
}

class ViewController: UIViewController {
    
    let redView = UIView()
    let blueView = UIView()
    
    override func loadView() {
        super.loadView()
        view = MyView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View Did Load: \(view.safeAreaInsets)")
        
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        blueView.backgroundColor = .systemBlue
        view.addSubview(blueView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before appearing the view.
        print("View Will Appear: \(view.safeAreaInsets)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        print("View Did Appear: \(view.safeAreaInsets)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("View Will Layout Subviews: \(view.safeAreaInsets)")
        layoutWithAutoLayout()
//        layoutWithFrame()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print("View Safe Area Insets Did Change: \(view.safeAreaInsets)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View Did Layout Subviews: \(view.safeAreaInsets)")
    }
    
    private func layoutWithFrame() {
        let margin: CGFloat = 20
        let padding: CGFloat = 10
        
        let horizontalInset = view.safeAreaInsets.left + view.safeAreaInsets.right
        let safeAreaWidth = view.frame.width - horizontalInset
        let viewWidth = (safeAreaWidth - margin * 2 - padding) / 2
        
        let verticalInset = view.safeAreaInsets.top + view.safeAreaInsets.bottom
        let safeAreaHeight = view.frame.height - verticalInset
        let viewHeight = safeAreaHeight - margin * 2
        
        redView.frame = CGRect(x: view.safeAreaInsets.left + 20,
                               y: view.safeAreaInsets.top + 20,
                               width: viewWidth,
                               height: viewHeight)
        blueView.frame = CGRect(x: redView.frame.maxX + padding,
                                y: redView.frame.minY,
                                width: viewWidth,
                                height: viewHeight)
    }
    
    private func layoutWithAutoLayout() {
        // BlueView Constraints
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        // RedView Constraints
        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: blueView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: blueView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: -20).isActive = true
        
        NSLayoutConstraint(item: blueView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -20).isActive = true
        
        // Padding
        NSLayoutConstraint(item: blueView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: redView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 10).isActive = true
        
        // Width
        NSLayoutConstraint(item: blueView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: redView,
                           attribute: .width,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
}

