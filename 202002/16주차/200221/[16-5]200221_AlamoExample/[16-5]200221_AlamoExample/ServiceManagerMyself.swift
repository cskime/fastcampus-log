//
//  ServiceManagerMyself.swift
//  [16-5]200221_AlamoExample
//
//  Created by cskim on 2020/02/21.
//  Copyright © 2020 cskim. All rights reserved.
//

import Alamofire

final class MyServiceManager {
  static let shared = MyServiceManager()
  private let reachability = NetworkReachabilityManager(host: "google.com")
  private init() {
    reachability?.startListening{ (status) in
      switch status {
      case .notReachable:               print("Not Reachable")
      case .reachable(.cellular):       print("Cellular")
      case .reachable(.ethernetOrWiFi): print("Ethernet or WiFi")
      case .unknown:                    print("Unknown")
      }
    }
  }
  
  // MARK: Request
  
  func requestUser(completionHandler: @escaping (Result<[User], Error>) -> Void) {
    let host = "https://go.aws/2PcKamh"
    AF.request(host)
      .validate()
      .responseDecodable { (response: DataResponse<[User], AFError>) in
        switch response.result {
        case .success(let users): completionHandler(.success(users))
        case .failure(let error): completionHandler(.failure(error))
        }
    }
  }
  
  func requestImage(_ url: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(url)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success(let data):  completionHandler(.success(data))
        case .failure(let error): completionHandler(.failure(error))
        }
    }
    
    guard let url = URL(string: url) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        return completionHandler(.failure(error!))
      }
      guard let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode) else {
          return
      }
      guard let data = data else { return }
      
      completionHandler(.success(data))
    }
  }
  
}
