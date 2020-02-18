//: # Nested Codable
import Foundation

let jsonData = """
{
  "message": "success",
  "number": 3,
  "people": [
    { "craft": "ISS", "name": "Anton Shkaplerov" },
    { "craft": "ISS", "name": "Scott Tingle" },
    { "craft": "ISS", "name": "Norishige Kanai" },
  ]
}
""".data(using: .utf8)!

// 안에 들어있는 것들까지 한번에 parsing
struct Astronauts: Decodable {
  let message: String
  let number: Int
  let people: [Person]
//  let people: [[String: String]]   이렇게하면 따로 구현했어야 할 것
  
  struct Person: Decodable {
    let name: String
  }
}

do {
  // Astronauts 타입으로 반환하면 내부에서 Person에 대해서도 자동으로 parsing
  let astronauts = try JSONDecoder().decode(Astronauts.self, from: jsonData)
  print(astronauts.message)
  print(astronauts.number)
  astronauts.people.forEach { print($0)}
} catch {
  print(error.localizedDescription)
}



//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
