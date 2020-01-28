//
//  CustomCell.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CustomCell: UICollectionViewCell {
  static let identifier = "CustomCell"
  
  private let imageView = UIImageView()
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
  
  private func setupViews() {
    self.layer.cornerRadius = 20
    self.clipsToBounds = true
    
    self.imageView.contentMode = .scaleAspectFill
    self.contentView.addSubview(self.imageView)
    
    self.titleLabel.textAlignment = .center
    self.titleLabel.textColor = .white
    self.titleLabel.font = .preferredFont(forTextStyle: .headline)
    self.contentView.addSubview(self.titleLabel)
  }
  
  private func setupConstraints() {
    [self.imageView, self.titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
    
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
  }
  
  // MARK: Configure Cell
  
  func configure(image: UIImage?, title: String) {
    self.imageView.image = image
    self.titleLabel.text = title
  }
  
}
