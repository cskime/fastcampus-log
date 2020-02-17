//: [Previous](@previous)
import Foundation


/*
 [ 실습1 ]
 다음 주소를 통해 얻은 json 데이터(국제정거장 위치 정보)를 파싱하여 출력하기
 http://api.open-notify.org/iss-now.json
 */

func practice1() {
  let urlStr = "http://api.open-notify.org/iss-now.json"
  guard let url = URL(string: urlStr) else { return }
  URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard error == nil else { return print(error!.localizedDescription) }
    guard
      let response = response as? HTTPURLResponse,
      (200..<300).contains(response.statusCode)
      else { return print("Invalid Response") }
    guard let data = data else { return print("Invalid Data") }
    
    if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
      let position = jsonObject["iss_position"] as? [String: String] {
      print("Latitude :", position["latitude"]!, "Longitude :", position["longitude"]!)
    }
  }.resume()
}
practice1()


/*
 [ 실습2 ]
 User 구조체 타입을 선언하고
 다음 Json 형식의 문자열을 User 타입으로 바꾸어 출력하기
 
 e.g.
 User(id: 1, firstName: "Robert", lastName: "Schwartz", email: "rob23@gmail.com")
 User(id: 2, firstName: "Lucy", lastName: "Ballmer", email: "lucyb56@gmail.com")
 User(id: 3, firstName: "Anna", lastName: "Smith", email: "annasmith23@gmail.com")
 */

let jsonString2 = """
{
  "users": [
    {
      "id": 1,
      "first_name": "Robert",
      "last_name": "Schwartz",
      "email": "rob23@gmail.com"
    },
    {
      "id": 2,
      "first_name": "Lucy",
      "last_name": "Ballmer",
      "email": "lucyb56@gmail.com"
    },
    {
      "id": 3,
      "first_name": "Anna",
      "last_name": "Smith",
      "email": "annasmith23@gmail.com"
    },
  ]
}
"""

struct User {
  var id: Int
  var firstName: String
  var lastName: String
  var email: String
}

func practice2() {
  guard
    let jsonData = jsonString2.data(using: .utf8),
    let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
    let users = jsonObject["users"] as? [[String: Any]]
    else { return }

  users.forEach {
    if let id = $0["id"] as? Int,
      let firstName = $0["first_name"] as? String,
      let lastName = $0["last_name"] as? String,
      let email = $0["email"] as? String {
      print(User(id: id, firstName: firstName, lastName: lastName, email: email))
    }
  }
}
practice2()



/*
 [ 실습3 ]
 Post 구조체 타입을 선언하고
 다음 주소를 통해 얻은 JSON 데이터를 파싱하여 Post 타입으로 변환한 후 전체 개수 출력하기
 https://jsonplaceholder.typicode.com/posts
 */

struct Post {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

func practice3() {
  let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
  URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data else { return }
    let jsonObjects = try! JSONSerialization.jsonObject(with: data) as! [[String: Any]]
    var posts = [Post]()
    for object in jsonObjects {
      if let userID = object["userId"] as? Int,
        let id = object["id"] as? Int,
        let title = object["title"] as? String,
        let body = object["body"] as? String {
        posts.append(Post(userId: userID, id: id, title: title, body: body))
      }
    }
    print("Number of Posts :", posts.count)
  }.resume()
}

practice3()




//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


