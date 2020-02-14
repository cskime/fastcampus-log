//
//  LogoView.swift
//  [6-5]191213_LoginExample
//
//  Created by cskim on 2019/12/13.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class LogoView: UIView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView = UIImageView()
    var dotView = DotView()

    private func setupUI() {
        imageView.image = UIImage(named: ImageKey.logo)
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraint() {
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        let topPadding: CGFloat = 24
        self.addSubview(dotView)
        dotView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dotView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: topPadding
            ),
            dotView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            dotView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
