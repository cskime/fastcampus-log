//
//  User.swift
//  AppleLoginExample
//
//  Created by Giftbot on 2020/03/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: String
  let familyName: String
  let givenName: String
  let email: String
}
