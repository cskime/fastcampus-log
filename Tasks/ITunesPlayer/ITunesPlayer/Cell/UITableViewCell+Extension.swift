//
//  UITableViewCell+Extension.swift
//  ITunesPlayer
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

// MARK:- UITableViewCell

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { String(describing: self) }
}

extension UITableViewCell: Identifiable {
  func configure(track: String, artist: String) {
    self.textLabel?.text = track
    self.detailTextLabel?.text = artist
  }
}
