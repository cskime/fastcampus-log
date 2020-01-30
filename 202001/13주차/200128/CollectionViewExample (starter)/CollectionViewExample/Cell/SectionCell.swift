//
//  SectionCell.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class SectionCell: UICollectionViewCell {
  static let identifier = "SectionCell"
  
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
    // imageView
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)
    
    // titleLabel
    titleLabel.textColor = .darkText
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    contentView.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    [imageView, titleLabel].forEach {
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
      titleLabel.heightAnchor.constraint(equalToConstant: 25)
      ])
    
//    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
  }

  
  // MARK: Configure Cell
  
  func configure(image: UIImage?, title: String) {
    imageView.image = image
    titleLabel.text = title
  }
}
