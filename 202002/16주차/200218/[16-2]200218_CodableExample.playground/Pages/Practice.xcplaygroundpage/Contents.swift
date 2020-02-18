//: [Previous](@previous)
import Foundation
import UIKit

let decoder = JSONDecoder()

/*
 1번 문제
 - 다음 JSON 내용을 Fruit 타입으로 변환
 */
print("\n---------- [ 1번 문제 (Fruits) ] ----------\n")
let jsonFruits = """
[
{
  "name": "Orange",
  "cost": 100,
  "description": "A juicy orange"
},
{
  "name": "Apple",
  "cost": 200
},
{
  "name": "Watermelon",
  "cost": 300
},
]
""".data(using: .utf8)!


struct Fruit: Codable {
  let name: String
  let cost: Int
  let description: String
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try values.decode(String.self, forKey: .name)
    self.cost = try values.decode(Int.self, forKey: .cost)
    let description = try? values.decode(String.self, forKey: .description)
    self.description = description ?? ""
  }
}
if let fruits = try? decoder.decode([Fruit].self, from: jsonFruits) {
  print("\n==================== Fruits ====================\n")
  fruits.forEach { print($0) }
}


/*
 2번 문제
 - 다음 JSON 내용을 Report 타입으로 변환
 */
print("\n---------- [ 2번 문제 (Report) ] ----------\n")
let jsonReport = """
{
  "name": "Final Results for iOS",
  "report_id": "905",
  "read_count": "10",
  "report_date": "2019-02-14",
}
""".data(using: .utf8)!

struct Report: Decodable {
  let name: String
  let reportID: String
  let readCount: String
  let reportDate: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case reportID = "report_id"
    case readCount = "read_count"
    case reportDate = "report_date"
  }
}
if let report = try? decoder.decode(Report.self, from: jsonReport) {
  print("\n==================== Report ====================\n")
  print(report)
}

/*
 3번 문제
 - Nested Codable 내용을 참고하여 다음 JSON 내용을 파싱
 */

print("\n---------- [ 3번 문제 (Movie) ] ----------\n")
let jsonMovie = """
[
  {
    "name": "Edward",
    "favorite_movies": [
      { "title": "Gran Torino", "release_year": 2008 },
      { "title": "3 Idiots", "release_year": 2009 },
      { "title": "Big Fish", "release_year": 2003 },
    ]
  }
]
""".data(using: .utf8)!

struct Person: Decodable {
  let name: String
  let favoriteMovies: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case name
    case favoriteMovies = "favorite_movies"
  }
  
  struct Movie: Decodable {
    let title: String
    let releaseYear: Int
    
    enum CodingKeys: String, CodingKey {
      case title
      case releaseYear = "release_year"
    }
  }
}
if let person = try? decoder.decode([Person].self, from: jsonMovie) {
  print("\n==================== Person Info ====================\n")
  print(person.first?.name ?? "")
  person.first?.favoriteMovies.forEach { print($0) }
}


/*
 4번 문제
 - 다음 URL의 Repository 정보 중에서 다음 속성만을 골라서 데이터 모델로 만들고 출력
 - https://api.github.com/search/repositories?q=user:giftbott
 - 위 URL의 user 부분을 자신의 아이디로 변경
 - let fullName: String
 - let description: String
 - let starCount: Int
 - let forkCount: Int
 - let url: String
 */

struct Repositories: Decodable {
  let items: [Item]
  
  struct Item: Decodable {
    let fullName: String
    let description: String
    let starCount: Int
    let forkCount: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
      case fullName = "full_name"
      case description
      case starCount = "stargazers_count"
      case forkCount = "forks_count"
      case url = "html_url"
    }
  }
  
}


func fetchGitHubRepositories() {
  let urlString = "https://api.github.com/search/repositories?q=user:giftbott"
  let url = URL(string: urlString)!
  URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard error == nil else { return print(error!.localizedDescription) }
    
    guard
      let response = response as? HTTPURLResponse,
      (200..<300).contains(response.statusCode)
      else { return }
    
    guard
      let data = data,
      let repos = try? decoder.decode(Repositories.self, from: data)
    else { return }
    
    print("\n==================== Repository Items ====================\n")
    repos.items.forEach { print($0) }
  }.resume()
}

fetchGitHubRepositories()



//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
