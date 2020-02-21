//
//  ServiceManager.swift
//  [16-5]200221_AlamoExample
//
//  Created by cskim on 2020/02/21.
//  Copyright © 2020 cskim. All rights reserved.
//

import Alamofire

final class ServiceManager {
  static let shared = ServiceManager()
  private let baseURL = "https://go.aws/2PcKamh"
  
  // Alamofire 없이 직접 만들어서 사용할 수도 있지만 복잡함
  // Internet 연결 상태를 확인하는 manager
  // host에는 Http 없이 주소만. 인터넷 상태를 체크하기 위한 site를 지정해 주는 것
  private var reachability = NetworkReachabilityManager(host: "google.com")
  
  private init() {
    reachability?.startListening { status in
      switch status {
      case .notReachable: print("Not Reachable")
      case .reachable(.cellular): print("cellular")
      case .reachable(.ethernetOrWiFi): print("ethernetOrWiFi")
      case .unknown:  print("Unknown")
      }
    }
    
    // 상태 체크를 멈추기
//    reachability?.stopListening()
  }
  
  // CompletionHandler를 언제 사용하나?
  // 비동기, 결과를 기다렸다가 응답을 받는 직후에 실행해야 하는 것 등
  // Result<Success, Error> 타입 : 성공과 실패에 대한 thorws 처리. Error가 발생할 수 있는 상황에서 사용하면 처리하기 좋다.
  func requestUser(completionHandler: @escaping (Result<[User], Error>) -> Void) {
    
    // URLSession은 URL 타입을 넣어야하지만 AF는 String을 넣어도 URL로 변환해줌
//    URLSession.shared.dataTask(with: T##URL)
    AF.request(self.baseURL)
      .validate() // default: 200..<300 status
//      .validate(statusCode: 200..<400)  // 설정을 바꿀 수도 있다.
//      .validate(contentType: ["application/json"])  // 받아오는 data 타입을 검사하는 것. 안하면 모든 타입에 대해 받겠다는 의미로 생각할 수 있다.
      // 매개변수를 사용하면 response 타입을 명시하지 않아도 됨
      // 비동기로 돌아온 작업이 수행될 thread 선택 가능. .main, .global()
//      .responseDecodable(of: [User].self, queue: .main, decoder: JSONDecoder(), completionHandler: T##(DataResponse<Decodable, AFError>) -> Void)
      .responseDecodable { (response: DataResponse<[User], AFError>) in
        // Code
        
        // 어떤 데이터가 들어왔을 떄, 그 closure한테 데이터를 넘겨주면
        // Request user라는 함수를 호출할 때 호출한 위치에서 completionhandler를 구현함
        // 호출한 곳에서 CH를 구현하게 되고, 네트워크를 통해 데이터를 받은 시점에서 실행 코드를 넘겨주면
        // 실제 코드 수행을 response가 도착한 시점으로 미룰 수 있다.
        // Result<>와 같은 방식으로 주로 사용됨. URLSession에서도 사용 가능
        switch response.result {
        case .success(let users):
          completionHandler(.success(users))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
    
  }
  
  func requestImage(_ url: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(url)
      .validate()
      .responseData { (response: DataResponse<Data, AFError>) in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
}
