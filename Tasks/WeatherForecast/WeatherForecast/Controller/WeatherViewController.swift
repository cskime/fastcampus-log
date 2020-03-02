//
//  ViewController.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  // MARK: Service
  
  private var provider: Provider!
  private let manager = LocationManager()
  
  // MARK: Views
  
  private let backgroundView = BackgroundView()
  private let titleView = LocationTitle()
  private let reloadButton: UIButton = {
    let button = UIButton()
    button.setTitle("↻", for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
    button.addTarget(self, action: #selector(reloadTouched(_:)), for: .touchUpInside)
    return button
  }()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CurrentCell.self)
    tableView.register(ForecastCell.self)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.allowsSelection = false
    return tableView
  }()
  
  // MARK: Properties
  
  private var current: WeatherCurrent? {
    didSet {
      self.tableView.alpha = 0
      self.tableView.transform = .init(translationX: self.view.frame.maxX, y: 0)
      UIView.animate(withDuration: 0.7) {
        self.tableView.alpha = 1
        self.tableView.transform = .identity
        self.tableView.reloadSections([0], with: .automatic)
      }
    }
  }
  private var shortRange = [WeatherShortRange.ShortRange]() {
    didSet {
      self.tableView.reloadSections([1], with: .automatic)
    }
  }
  
  private var contentInset: CGFloat {
    get {
      self.view.safeAreaInsets.top + self.titleView.frame.height
    }
  }
  
  // MARK: Initialize
  
  init(provider: Provider) {
    super.init(nibName: nil, bundle: nil)
    self.provider = provider
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let cellHeight = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame.height ?? 0
    let offset = self.view.frame.height - self.contentInset - cellHeight
    self.tableView.contentInset = .init(top: offset, left: 0, bottom: 0, right: 0)
  }
  
  private func setupUI() {
    self.setupAttributes()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.view.backgroundColor = .systemBackground
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.manager.delegate = self
  }
  
  private func setupConstraints() {
    [self.backgroundView, self.titleView, self.reloadButton, self.tableView].forEach { self.view.addSubview($0) }
    
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
    let guide = self.view.safeAreaLayoutGuide
    self.titleView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.titleView.topAnchor.constraint(equalTo: guide.topAnchor),
      self.titleView.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
    ])
    
    self.reloadButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.reloadButton.topAnchor.constraint(equalTo: self.titleView.topAnchor),
      self.reloadButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
      self.reloadButton.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor)
    ])
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
  }
  
  // MARK: Methods
  
  private func requestCurrentWeather(lat: Double, lon: Double) {
    self.provider.requestCurrent(lat: lat, lon: lon) {[weak self] (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let current):
          print(current)
          self?.current = current
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  private func requestShortRangeForecast(lat: Double, lon: Double) {
    self.provider.requestShortRange(lat: lat, lon: lon) {[weak self] (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let weatherShortRange):
          print(weatherShortRange)
          self?.shortRange = weatherShortRange.shortRanges
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  // MARK: Actions
  
  @objc private func reloadTouched(_ sender: UIButton) {
    self.manager.startUpdatingLocation()
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
      sender.transform = .init(rotationAngle: 3.14)
    }) { (_) in
      UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
        sender.transform = .init(rotationAngle: 3.14 * 2)
      }) { (_) in
        sender.transform = .identity
      }
    }
  }

  // MARK: Useless
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK:- LocationManager

extension WeatherViewController: LocationManagerDelegate {
  func locationManager(_ manager: LocationManager, didReceiveLocation location: Location) {
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    self.requestCurrentWeather(lat: latitude, lon: longitude)
    self.requestShortRangeForecast(lat: latitude, lon: longitude)
  }
  
  func locationManager(_ manager: LocationManager, didReceiveAddress address: String?) {
    guard let address = address else { return }
    self.titleView.configure(address: address, date: Date())
  }
}

// MARK:- UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : self.shortRange.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(CurrentCell.self, for: indexPath)
      guard let current = current else { return cell }
      let skyName = current.sky.name
      let skyCode = current.sky.code.replacingOccurrences(of: "_O", with: "_")
      let currentTemp = current.temperature.tc
      let minTemp = current.temperature.tmin
      let maxTemp = current.temperature.tmax
      
      cell.configure(weather: skyName,
                     image: skyCode,
                     minTemp: minTemp,
                     maxTemp: maxTemp,
                     currentTemp: currentTemp)
      return cell
    default:
      let cell = tableView.dequeue(ForecastCell.self, for: indexPath)
      let shortRange = self.shortRange[indexPath.row]
      
      let date = shortRange.date
      let skyCode = shortRange.skyCode.replacingOccurrences(of: "_S", with: "_")
      let temp = shortRange.temperature
      
      cell.configure(date: date, image: skyCode, temperature: temp)
      return cell
    }
  }
}

// MARK:- UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let inset = scrollView.contentInset.top
    let offset = scrollView.contentOffset.y
    let alpha = 1 + offset / inset
    
    self.backgroundView.updateBlurView(alpha: min(0.8, alpha))
    self.backgroundView.updateParallazEffect(transitionX: 30 * min(1, alpha))
  }
}
