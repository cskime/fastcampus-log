//
//  Pets.swift
//  CustomLogExample
//
//  Created by giftbot on 2020/01/30.
//  Copyright © 2020 giftbot. All rights reserved.
//

import Foundation

class Dog: CustomStringConvertible, CustomDebugStringConvertible {
  var debugDescription: String {
    "Dog's name: \(name), age: \(age), feature: \(feature)"
  }
  
  var description: String {
    "Dog's name: \(name), age: \(age)"
  }
  
  let name = "Tory"
  let age = 5
  let feature: [String: String] = [
    "breed": "Poodle",
    "tail": "short"
  ]
}

struct Cat {
  let name = "Lilly"
  let age = 2
  let feature: [String: String] = [
    "breed": "Koshort",
    "tail": "short"
  ]
}
