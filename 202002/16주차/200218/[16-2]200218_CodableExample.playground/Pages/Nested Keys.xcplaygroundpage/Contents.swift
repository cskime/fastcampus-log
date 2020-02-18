//: [Previous](@previous)
//: # Nested Keys
import Foundation


let jsonData = """
[
{
  "latitude": 30.0,
  "longitude": 40.0,
  "additionalInfo": {
    "elevation": 50.0,
  }
},
{
  "latitude": 60.0,
  "longitude": 120.0,
  "additionalInfo": {
    "elevation": 20.0
  }
}
]
""".data(using: .utf8)!


struct Coordinate {
  // elevation은 같은 level에 없기 때문에
  var latitude: Double
  var longitude: Double
  var elevation: Double
  
  // additionalInfo가 필요하다면
//  var additionalInfo: [String: Double]
//  lazy var elevation: Double = self.additionalInfo["elevation"]

  // CodingKeys에서는 json data에서의 key들을 갖고
  enum CodingKeys: String, CodingKey {
    case latitude
    case longitude
    case additionalInfo
  }
  // 다른 level에 있는 key에 대해서도 codingkey 구현
  // CodingKeys는 이름을 지켜야하지만
  // 그 외 nested key에 대한 enum은 이름 자유
  enum AdditionalInfoKeys: String, CodingKey {
    case elevation
  }
}


extension Coordinate: Decodable {
  // throws가 있으면 함수 안에서는 try만 사용하고, 오류가 발생하면 해당 함수를
  // 호출한 외부에서 오류를 처리함
  init(from decoder: Decoder) throws {
    // Container available keys : latiitude, longitude, additionalInfo
    let values = try decoder.container(keyedBy: CodingKeys.self)
    latitude = try values.decode(Double.self, forKey: .latitude)
    longitude = try values.decode(Double.self, forKey: .longitude)

    // additionalInfo 안에 들어있는 것 가졍오기.
    // nested dic에 대해 nestedContainer로 가져옴
    let additionalInfo = try values.nestedContainer(
      keyedBy: AdditionalInfoKeys.self,
      forKey: .additionalInfo
    )
    elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
  }
}


extension Coordinate: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(latitude, forKey: .latitude)
    try container.encode(longitude, forKey: .longitude)

    var additionalInfo = container.nestedContainer(
      keyedBy: AdditionalInfoKeys.self,
      forKey: .additionalInfo
    )
    try additionalInfo.encode(elevation, forKey: .elevation)
  }
}


do {
  let coordinates = try JSONDecoder().decode([Coordinate].self, from: jsonData)
  coordinates.forEach { print($0) }
} catch {
  print(error.localizedDescription)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
