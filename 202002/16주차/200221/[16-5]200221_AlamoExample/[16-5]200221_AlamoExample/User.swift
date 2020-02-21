//
//  User.swift
//  [16-5]200221_AlamoExample
//
//  Created by cskim on 2020/02/21.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

let jsonData = """
{
  "name": "Alina",
  "surname": "Grecescu",
  "gender": "female",
  "region": "Romania",
  "age": 34,
  "title": "ms",
  "phone": "(748) 937 8858",
  "birthday": {
    "dmy": "07/09/1986",
    "mdy": "09/07/1986",
    "raw": 526451656
  },
  "email": "alina_86@example.com",
  "password": "Grecescu86&^",
  "credit_card": {
    "expiration": "3/25",
    "number": "5745-8712-3746-6978",
    "pin": 4405,
    "security": 183
  },
  "photo": "https://uinames.com/api/photos/female/16.jpg"
}
""".data(using: .utf8)

struct CreditCard: Decodable {
  let expiration: String
  let number: String
  let pin: Int
  let security: Int
}
struct User: Decodable {
  let fullName: String
  let phone: String
  let birthDay: Date
  let email: String
  let creditCard: CreditCard
  let photo: String
  
  private enum CodingKeys: String, CodingKey {
    case name
    case surname
    case phone
    case birthDay = "birthday"
    case email
    case creditCard = "credit_card"
    case photo
  }
  
  private enum BirthdayCodingKeys: String, CodingKey {
    case dmy, mdy, raw
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    print("Start Parse")
    
    let name = try values.decode(String.self, forKey: .name)
    let surname = try values.decode(String.self, forKey: .surname)
    self.fullName = name + " " + surname
    print("Parse Name")
    
    self.phone = try values.decode(String.self, forKey: .phone)
    print("Parse Phone")
    self.email = try values.decode(String.self, forKey: .email)
    print("Parse Email")
    self.creditCard = try values.decode(CreditCard.self, forKey: .creditCard)
    print("Parse CreditCard")
    self.photo = try values.decode(String.self, forKey: .photo)
    print("Parse Photo")
    
    let nestedValues = try values.nestedContainer(keyedBy: BirthdayCodingKeys.self,
                                              forKey: .birthDay)
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    let dateString = try nestedValues.decode(String.self, forKey: .dmy)
    self.birthDay = formatter.date(from: dateString) ?? Date()
    print("Parse Birthday")
  }
}
