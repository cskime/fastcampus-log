//
//  CustomCell.swift
//  CollectionViewPractice
//
//  Created by cskim on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
  static let identifier = String(describing: CustomCell.self)
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let checkImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    imageView.tintColor = .white
    imageView.isHidden = true
    return imageView
  }()
  
  private lazy var blindView = UIView(frame: self.frame)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = 16
    self.clipsToBounds = true
    self.selectedBackgroundView = {
      let view = UIView()
      view.backgroundColor = .red
      return view
    }()
    self.setupConstraints()
  }
  
  override var isSelected: Bool {
    didSet {
      print("isSelected :", isSelected)
      self.checkImageView.isHidden = !self.isSelected
      self.blindView.backgroundColor = self.isSelected ? UIColor.black.withAlphaComponent(0.4) : .clear
    }
  }
  
  private func setupConstraints() {
    let contents = [self.imageView, self.checkImageView, self.blindView]
    contents.forEach { self.contentView.addSubview($0) }
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
    ])
    
    self.blindView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.blindView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.blindView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.blindView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.blindView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
    ])
    
    self.checkImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        self.checkImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
        self.checkImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
        self.checkImageView.widthAnchor.constraint(equalToConstant: 32),
        self.checkImageView.heightAnchor.constraint(equalToConstant: 32),
    ])
    
  }
  
  func configureContents(image: UIImage?) {
    self.imageView.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
