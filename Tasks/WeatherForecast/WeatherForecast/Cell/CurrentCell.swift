//
//  CurrentCell.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/24.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class CurrentCell: UITableViewCell {
  
  static let identifier = String(describing: CurrentCell.self)
  
  // MARK: Interface
  
  func configure(weather skyName: String, image skyCode: String, minTemp: String, maxTemp: String, currentTemp: String) {
    self.currentLabel.text = skyName
    self.currentImageView.image = UIImage(named: skyCode)
    self.minTempLabel.text = self.formattedTemperature(string: minTemp)
    self.maxTempLabel.text = self.formattedTemperature(string: maxTemp)
    self.currentTempLabel.text = self.formattedTemperature(string: currentTemp)
  }
  
  private func formattedTemperature(string: String = "") -> String {
    let temp = Double(string)
    return String(format: "%.1f", temp ?? 0) + "º"
  }
  
  // MARK: UIs
  
  private let currentLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    label.textColor = .white
    return label
  }()
  private let currentImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let currentTempLabel: UILabel = {
    let label = UILabel()
    label.text = "0.0º"
    label.textColor = .white
    label.font = .systemFont(ofSize: 88, weight: .thin)
    return label
  }()
  
  private let minTempLabel: UILabel = {
    let label = UILabel()
    label.text = "0.0º"
    label.textColor = .white
    label.font = .systemFont(ofSize: 18)
    return label
  }()
  private let minTempSymbol: UILabel = {
    let label = UILabel()
    label.text = "⤓"
    label.textColor = .white
    return label
  }()
  
  private let maxTempLabel: UILabel = {
    let label = UILabel()
    label.text = "0.0º"
    label.textColor = .white
    label.font = .systemFont(ofSize: 18)
    return label
  }()
  private let maxTempSymbol: UILabel = {
    let label = UILabel()
    label.text = "⤒"
    label.textColor = .white
    return label
  }()
  
  // MARK: Initialie
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.setupAttributes()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.backgroundColor = .clear
  }
  
  private struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
    static let imageSize: CGFloat = 48
  }
  private func setupConstraints() {
    let contents = [self.currentLabel, self.currentImageView]
    contents.forEach { self.contentView.addSubview($0) }
    
    self.currentImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.currentImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.currentImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      self.currentImageView.widthAnchor.constraint(equalToConstant: UI.imageSize),
      self.currentImageView.heightAnchor.constraint(equalToConstant: UI.imageSize),
    ])
    
    self.currentLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.currentLabel.leadingAnchor.constraint(equalTo: self.currentImageView.trailingAnchor, constant: UI.spacing),
      self.currentLabel.bottomAnchor.constraint(equalTo: self.currentImageView.bottomAnchor),
    ])
    
    let minStackView = UIStackView()
    minStackView.axis = .horizontal
    minStackView.alignment = .fill
    minStackView.distribution = .fillProportionally
    minStackView.spacing = UI.spacing
    [self.minTempSymbol, self.minTempLabel].forEach { minStackView.addArrangedSubview($0) }
    self.contentView.addSubview(minStackView)
    
    minStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.minTempSymbol.widthAnchor.constraint(equalToConstant: UI.imageSize / 2),
      self.minTempSymbol.heightAnchor.constraint(equalToConstant: UI.imageSize / 2),
      
      minStackView.topAnchor.constraint(equalTo: self.currentImageView.bottomAnchor, constant: UI.spacing),
      minStackView.leadingAnchor.constraint(equalTo: self.currentImageView.leadingAnchor),
    ])
    self.minTempLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    let maxStackView = UIStackView()
    maxStackView.axis = .horizontal
    maxStackView.alignment = .fill
    maxStackView.distribution = .fill
    maxStackView.spacing = UI.spacing
    [self.maxTempSymbol, self.maxTempLabel].forEach { minStackView.addArrangedSubview($0) }
    self.contentView.addSubview(maxStackView)
    
    maxStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.maxTempSymbol.widthAnchor.constraint(equalToConstant: UI.imageSize / 2),
      self.maxTempSymbol.heightAnchor.constraint(equalToConstant: UI.imageSize / 2),
      
      maxStackView.leadingAnchor.constraint(equalTo: minStackView.trailingAnchor, constant: UI.spacing),
      maxStackView.centerYAnchor.constraint(equalTo: minStackView.centerYAnchor),
    ])
    self.maxTempLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    self.contentView.addSubview(self.currentTempLabel)
    self.currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.currentTempLabel.topAnchor.constraint(equalTo: minStackView.bottomAnchor, constant: UI.paddingY),
      self.currentTempLabel.leadingAnchor.constraint(equalTo: minStackView.leadingAnchor),
      self.currentTempLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
