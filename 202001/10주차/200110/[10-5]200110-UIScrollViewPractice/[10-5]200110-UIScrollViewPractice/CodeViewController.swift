//
//  CodeViewController.swift
//  [10-5]200110-UIScrollViewPractice
//
//  Created by cskim on 2020/01/10.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        let guide = self.view.safeAreaLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
        
        let grayView = UIView()
        grayView.backgroundColor = .gray
        self.view.addSubview(grayView)
        grayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grayView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            grayView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            grayView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            grayView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            grayView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5),
        ])
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        self.view.addSubview(yellowView)
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            yellowView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            yellowView.bottomAnchor.constraint(equalTo: grayView.topAnchor),
            yellowView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            yellowView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5),
        ])
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        self.view.addSubview(blueView)
        blueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: yellowView.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: yellowView.trailingAnchor),
            blueView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: yellowView.bottomAnchor),
        ])
    }

}
