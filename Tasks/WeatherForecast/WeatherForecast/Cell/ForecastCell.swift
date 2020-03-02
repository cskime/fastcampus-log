//
//  ForecastCell.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/24.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
  
  static let identifier = String(describing: ForecastCell.self)
  
  // MARK: Interface
  
  func configure(date: Date, image: String, temperature: String) {
    let formatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "ko_kr")
      formatter.dateFormat = "M.dd(EEE) HH:mm"
      return formatter
    }()
    let dateComponents = formatter.string(from: date).components(separatedBy: " ")
    self.dateLabel.text = dateComponents.first ?? ""
    self.timeLabel.text = dateComponents.last ?? ""
    self.weatherImageView.image = UIImage(named: image)
    self.tempLabel.text = self.formattedTemperature(string: temperature)
  }
  
  private func formattedTemperature(string: String = "") -> String {
    return String(format: "%.1f", Double(string) ?? 0) + "º"
  }
  
  // MARK: UIs
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "0.00(-)"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "00:00"
    label.textColor = .white
    label.font = .systemFont(ofSize: 18)
    return label
  }()
  private let tempLabel: UILabel = {
    let label = UILabel()
    label.text = "0.0º"
    label.textColor = .white
    label.font = .systemFont(ofSize: 28)
    return label
  }()
  
  private let weatherImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let underline: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  
  // MARK: Initialzie
  
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
    let dateStackView = UIStackView()
    dateStackView.axis = .vertical
    dateStackView.alignment = .leading
    dateStackView.distribution = .fill
    dateStackView.spacing = 4
    [self.dateLabel, self.timeLabel].forEach { dateStackView.addArrangedSubview($0) }
    
    [dateStackView, self.weatherImageView, self.underline, self.tempLabel].forEach { self.contentView.addSubview($0) }
    
    self.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.weatherImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.weatherImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: UI.spacing * 3),
      self.weatherImageView.widthAnchor.constraint(equalToConstant: UI.imageSize),
      self.weatherImageView.heightAnchor.constraint(equalToConstant: UI.imageSize),
    ])
    
    self.underline.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.underline.topAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor, constant: UI.paddingY * 2),
      self.underline.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
      self.underline.centerXAnchor.constraint(equalTo: self.weatherImageView.centerXAnchor),
      self.underline.widthAnchor.constraint(equalTo: self.weatherImageView.widthAnchor),
      self.underline.heightAnchor.constraint(equalToConstant: 1),
    ])
    
    self.tempLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.tempLabel.topAnchor.constraint(equalTo: self.weatherImageView.topAnchor),
      self.tempLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.tempLabel.bottomAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor),
    ])
    
    dateStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateStackView.topAnchor.constraint(equalTo: self.weatherImageView.topAnchor),
      dateStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      dateStackView.bottomAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
