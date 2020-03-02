//
//  BackgroundView.swift
//  WeatherForecast
//
//  Created by cskim on 2020/03/01.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
  
  // MARK: Interface
  
  func updateBlurView(alpha: CGFloat) {
    self.blurView.alpha = alpha
  }
  
  func updateParallazEffect(transitionX: CGFloat) {
    self.backgroundImageView.transform = .init(translationX: transitionX, y: 0)
  }
  
  // MARK: Views
  
  private let backgroundImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: ImageReference.sunny.rawValue))
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let blurView: UIVisualEffectView = {
    let visualView = UIVisualEffectView()
    visualView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    visualView.alpha = 0
    return visualView
  }()
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupConstraints()
  }
  
  private func setupConstraints() {
    [self.backgroundImageView, self.blurView].forEach { self.addSubview($0) }
    
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
      self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
    
    self.blurView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.blurView.topAnchor.constraint(equalTo: self.topAnchor),
      self.blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
