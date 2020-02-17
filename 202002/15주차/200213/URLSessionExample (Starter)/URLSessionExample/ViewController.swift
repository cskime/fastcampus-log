//
//  ViewController.swift
//  URLSessionExample
//
//  Created by giftbot on 2020. 2. 12..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  private let imageUrlStr = "https://loremflickr.com/860/640/cat"
  
  
  // MARK: - Sync method
  
  @IBAction private func syncMethod() {
    print("\n---------- [ syncMethod ] ----------\n")
    let url = URL(string: imageUrlStr)!
    
    // Data(contentsOf:) : sync method
    // 1. URLSession
    // 2. Async
    
    // 1. URUSession
    URLSession.shared.dataTask(with: url) { (data, r, e) in
      if let data = data {
        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
      }
    }.resume()
    
    
    // DispatchQueue.mainl.async로 감싸게 되면 serial queue이므로 Data(contentsOf:) 작업을 할 때는 main queue에 다른 작업을 못하게 됨
    
//    // 2. Async
//    DispatchQueue.global().async {
//      if let data = try? Data(contentsOf: url) {
//        DispatchQueue.main.async {
//          self.imageView.image = UIImage(data: data)
//        }
//
//      }
//    }
    
  }
  
  
  // MARK: - URLComponents
  
  @IBAction private func urlComponentsExample(_ sender: Any) {
    print("\n---------- [ urlComponentsExample ] ----------\n")
    /*
     http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#myFragment
     */
    // 위 URL 구성을 보고 URLComponents의 각 파트를 수정해 위 구성과 같도록 만들어보기
    
    // URLComponents로 URL 생성
    var components = URLComponents()
    components.scheme = "http"
    components.user = "username"
    components.password = "password"
    components.host = "www.example.com"
    components.port = 80
    components.path = "/index.html"    // path는 /로 시작해야 함
    components.query = "key1=value1&key2=value2"
//    components.queryItems = [
//      .init(name: "key1", value: "value1"),
//      .init(name: "key2", value: "value2")
//    ]
    components.fragment = "myFragment"
    // fragment :
    
    print(components)
    
    // URL로부터 URLComponents 생성
    let url = URL(string: "http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#myFragment")!
//    let comp = URLComponents(string: "http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#myFragment")
    var comp = URLComponents(url: url, resolvingAgainstBaseURL: true)
    print(comp?.scheme ?? "")
    print(comp?.user ?? "")
    print(comp?.password ?? "")
    print(comp?.host ?? "")
    print(comp?.port ?? "")
    print(comp?.path ?? "")
    print(comp?.query ?? "")
    print(comp?.fragment ?? "")
    
    
    comp?.queryItems = [
      URLQueryItem(name: "name", value: "tory"),
      URLQueryItem(name: "age", value: "5"),
    ]
    print(comp?.url?.absoluteString ?? "")
    // 어떤 query를 담아서 요청을 보내는지에 따라 다른 Data를 받게 됨
  }
  
  
  
  // MARK: - URL Encoding Example
  
  @IBAction private func urlEncodingExample() {
    print("\n---------- [ urlEncodingExample ] ----------\n")
    
    // English URL
    let urlStringE = "https://www.naver.com/search.naver?.query=swift"
    print(URL(string: urlStringE) ?? "Nil")
    
    // Korean URL
    let urlStringK = "https://www.naver.com/search.naver?.query=한글"
    print(URL(string: urlStringK) ?? "Nil")
    // URI는 ASCII만 인코딩 가능하므로, 유니코드인 한글을 사용할 수 없음
    // 한글을 포함하여 ASCII가 아닌 문자들에 대해 URL을 사용하려면 Percent Encoding이 필요함
    
    // Korean URL - with Percent Encoding
    let str = "https://www.naver.com/search.naver?.query=한글"
    let queryEncodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let convertedURL = URL(string: queryEncodedStr)!
    print(convertedURL)
    
    /* URL -> String */
    // %23은 #을 나타내지만, fragment 기호인 #와 혼동될 수 있으므로 %23으로 표시하고
    // 실제로 쓸 때는 다시 percent encoding을 제거하고 다시 #으로 변환해서 사용해야함
    let encodedUrlString = "https://example.com/#color-%23708090"
    print(encodedUrlString.removingPercentEncoding!)
    
    
    /* String -> URL */
    let originalString = "color-#708090"
    
    let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)! // fragment에 대해 percent encoding 지정
    print(encodedString)
    
    // 특정 값은 문자 그대로 활용해야 한다면
    var allowed = CharacterSet.urlFragmentAllowed
    allowed.insert("#")
    let allowedEncodedString = originalString.addingPercentEncoding(withAllowedCharacters: allowed)!
    print(allowedEncodedString)
  }
  
  
  
  // MARK: - Session Configuration
  
  @IBAction private func sessionConfig(_ sender: Any) {
    print("\n---------- [ Session Configuration ] ----------\n")
    
    // URLSession Shared를 사용하지 않는다면 URLSessionConfiguration을 사용해야함
    // URLSessionConfigureation.default를 사용할 바엔 shared를 사용하는게 좋음
    _ = URLSessionConfiguration.default
    _ = URLSessionConfiguration.ephemeral // Session 사용 도중 발생하는 데이터들을 cache하지 않음
    _ = URLSessionConfiguration.background(withIdentifier: "com.cskm.example.configBackground")
  
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.allowsCellularAccess = false  // Default true. WIFI만 사용 가능. Cellular 불가
    sessionConfig.httpMaximumConnectionsPerHost = 5 // default 4. 몇명까지
    sessionConfig.timeoutIntervalForRequest = 20  // default 60(1 minute)
    sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData  // default .useProtocolCachePolicy
    sessionConfig.waitsForConnectivity = true // default false. netwalk 불안정 등 연결에 실패했을 때 바로 실패를 반환할 것인지 안정적일 때를 기다릴 것인지.
    
    // 기본 캐시 URLCache.shared
    // 메모리 : 16KB (16 * 1024 = 16_384)
    // 디스크 : 256 MB (256 * 1024 = 268_435_456)
    let myCache = URLCache(memoryCapacity: 16_384, diskCapacity: 268_435_456, diskPath: nil)
    sessionConfig.urlCache = myCache  // default URLCache.shared

    let cache = URLCache.shared
    sessionConfig.urlCache = cache
    print(cache.diskCapacity)       // 512000 / 1024 = 500KB
    print(cache.currentDiskUsage)   // 0
    print(cache.memoryCapacity)     // 100000000 / 1024 = 약 9.5MB
    print(cache.currentMemoryUsage) // 2073546
    
    // path : (user home directory)/Library/Caches/(application bundle id)
    // path에 file로 저장됨
    
    cache.removeAllCachedResponses()
    
    // Default URLSession.shared
    let mySession = URLSession(configuration: sessionConfig)
    let url = URL(string: imageUrlStr)!
    let task = mySession.dataTask(with: url) { [weak self] (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self?.imageView.image = UIImage(data: data)!
        print("download complete")
      }
    }
    task.resume()
  }
  

  // MARK: - Get, Post, Delete
  
  // https://jsonplaceholder.typicode.com/
  
  @IBAction func requestGet(_ sender: Any) {
    print("\n---------- [ Get Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    guard let url = URL(string: todoEndpoint) else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return print(error!.localizedDescription) }
      guard
        let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode),
        response.mimeType == "application/json"   // 실제 들어오는 데이터의 타입 정보. 생략하기도 함. 여기서는 JSON type을 받겠다는 의미
        else { return }
      guard let data = data else { return print("No Data") }
      guard
        let todo = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        let todoID = todo["id"] as? Int,
        let todoTitle = todo["title"] as? String
        else { return print("Could not get parsed data") }
      
      print("ID :", todoID)
      print("Title :", todoTitle)
    }
    task.resume()
  }
  
  
  @IBAction func requestPost(_ sender: Any) {
    print("\n---------- [ Post Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
    guard let todosURL = URL(string: todoEndpoint) else { return }
    
    let newTodo: [String: Any] = [
      "title": "My Todo",
      "userID": "20"
    ]
    guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newTodo) else { return }
    
    // METHOD를 POST로 변경하고 전송할 데이터를 넣기 위해 URLRequest 생성
    var urlRequest = URLRequest(url: todosURL)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = jsonTodo
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard
        let data = data,
        let newItem = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return }
      print(newItem)
      if let id = newItem["id"] as? Int {
        print(id)
      }
    }
    task.resume()
  }
  
  @IBAction func requestDelete(_ sender: Any) {
    print("\n---------- [ Delete Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1" // 정확히 지울 부분을 지정
    
    let url = URL(string: todoEndpoint)!
    // URLREquest로 url 지정하고 method 변경
    // 지우기만 하면 되니까 body에 데이터 넣지 않아도 됨
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard error == nil else { return print(error!.localizedDescription) }
      guard let data = data else { return print("NO DATA") }
      print("DELETE ok")
      
      print((response as! HTTPURLResponse).statusCode)
      
      if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        print(data)
        print(jsonObject)
      }
    }
    task.resume()
  }
}

