//
//  ViewController.swift
//  [10-5]200110-UIScrollViewHomework
//
//  Created by cskim on 2020/01/10.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    let colors: [UIColor] = [#colorLiteral(red: 0, green: 0.5467656255, blue: 0.9732442498, alpha: 1), #colorLiteral(red: 0.7100165486, green: 0.4391632974, blue: 0.9186503887, alpha: 1), #colorLiteral(red: 0.7431278825, green: 0.9347802401, blue: 0.2399184704, alpha: 1), #colorLiteral(red: 1, green: 0.4052651227, blue: 0.4514015317, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)]
    var contentViews = [UIView]()

    private func setupUI() {
        self.view.addSubview(self.scrollView)
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        colors.enumerated().forEach { (index, color) in
            let view = UIView()
            view.backgroundColor = color
            view.tag = index
            self.scrollView.addSubview(view)
            self.contentViews.append(view)
        }
        
        self.view.insertSubview(self.pageControl, aboveSubview: self.scrollView)
        self.pageControl.numberOfPages = contentViews.count
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.setupConstraints()
        self.setupContentConstrints()
    }
    
    private func setupConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let guide = self.view.safeAreaLayoutGuide
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pageControl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            self.pageControl.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupContentConstrints() {
        var targetView: UIView = self.scrollView
        var isFirstContent = true
        contentViews.forEach { (contentView) in
            contentView.translatesAutoresizingMaskIntoConstraints = false
            if isFirstContent {
                NSLayoutConstraint.activate([
                    contentView.topAnchor.constraint(equalTo: targetView.topAnchor),
                    contentView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
                    contentView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
                    contentView.widthAnchor.constraint(equalTo: targetView.widthAnchor),
                    contentView.heightAnchor.constraint(equalTo: targetView.heightAnchor),
                ])
                isFirstContent.toggle()
            } else {
                NSLayoutConstraint.activate([
                    contentView.topAnchor.constraint(equalTo: targetView.topAnchor),
                    contentView.leadingAnchor.constraint(equalTo: targetView.trailingAnchor),
                    contentView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
                    contentView.widthAnchor.constraint(equalTo: targetView.widthAnchor),
                    contentView.heightAnchor.constraint(equalTo: targetView.heightAnchor),
                ])
            }
            targetView = contentView
        }
        let lastIndex = contentViews.count - 1
        contentViews[lastIndex].trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
    }
}

// MARK:- UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.contentSize.width / CGFloat(contentViews.count)
        let currentPage = scrollView.contentOffset.x / pageWidth
        self.pageControl.currentPage = Int(currentPage)
    }
}
