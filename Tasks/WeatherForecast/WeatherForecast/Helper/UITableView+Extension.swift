//
//  UITableView+Extension.swift
//  WeatherForecast
//
//  Created by cskim on 2020/03/01.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { get { return String(describing: self)} }
}

extension UITableViewCell: Identifiable { }

extension UITableView {
  func register<Cell>(_ cell: Cell.Type) where Cell: UITableViewCell{
    self.register(cell, forCellReuseIdentifier: cell.identifier)
  }
  
  func dequeue<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell
  }
}
