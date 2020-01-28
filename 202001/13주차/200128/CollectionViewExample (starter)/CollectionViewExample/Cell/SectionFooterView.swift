//
//  SectionFooterView.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit


final class SectionFooterView: UICollectionReusableView {
  static let identifier = "SectionFooterView"
  
  private let titleLabel = UILabel()
  
  // MARK: Init
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  // MARK: Setup
  
  func setupViews() {
    titleLabel.textColor = .black
    titleLabel.textAlignment = .right
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    addSubview(titleLabel)
  }
  
  func setupConstraints() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      ])
  }
  
  
  // MARK: Configure
  
  func configure(title: String) {
    titleLabel.text = title
  }
}

