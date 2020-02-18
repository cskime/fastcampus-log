//: [Previous](@previous)
import Foundation

let jsonData = """
{
  "user_name": "James",
  "user_email": "abc@xyz.com",
  "gender": "male",
}
""".data(using: .utf8)!


struct User: Decodable {  // Encoode 필요 없을 때 Decodable만 사용
  // Decodable은 변수 이름과 json key name이 같다고 생각하고 parsing함
  let name: String    // json의 key 이름과 변수 이름이 다름
  let email: String   // 다른 언어에서는 key 이름을 다른 형식으로 사용할 수 있음
  let gender: String
  
  private enum CodingKeys: String, CodingKey {
    case name = "user_name"     // key 이름을 직접 지정해야함
    case email = "user_email"   // keyNotFound
    case gender
  }
}


let decoder = JSONDecoder()
let user = try decoder.decode(User.self, from: jsonData)
print(user)


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
