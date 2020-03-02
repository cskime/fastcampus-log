//
//  LocationTitle.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/24.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class LocationTitle: UIView {
  
  // MARK: Interface
  
  func configure(address: String, date: Date) {
    self.addressLabel.text = address
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko")
    formatter.dateFormat = "a h:mm"
    self.timeLabel.text = formatter.string(from: date)
  }
  
  // MARK: UIs
  
  private let addressLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  // MARK: Initialize
  
  init() {
    super.init(frame: .zero)
    self.addressLabel.text = "--시 --구"
    self.timeLabel.text = "--:--"
    self.setupConstraints()
  }
  
  private struct UI {
    static let paddingY: CGFloat = 8
  }
  private func setupConstraints() {
    let subviews = [self.addressLabel, self.timeLabel]
    subviews.forEach { self.addSubview($0) }
    
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.addressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UI.paddingY),
      self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.timeLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor),
      self.timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
