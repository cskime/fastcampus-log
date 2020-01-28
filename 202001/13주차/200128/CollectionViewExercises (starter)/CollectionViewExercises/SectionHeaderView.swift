//
//  SectionHeaderView.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  static let identifier = "SectionHeaderView"
  private let titleLabel = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  
  private func setupView() {
    titleLabel.textColor = .darkText
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
  
  
  // MARK: Configure
  
  func configure(title: String) {
    titleLabel.text = title
  }
}
