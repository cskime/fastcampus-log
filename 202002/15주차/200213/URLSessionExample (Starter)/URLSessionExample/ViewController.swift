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
  }
  
  
  
  // MARK: - Session Configuration
  
  @IBAction private func sessionConfig(_ sender: Any) {
    print("\n---------- [ Session Configuration ] ----------\n")
    
  }
  

  // MARK: - Get, Post, Delete
  
  // https://jsonplaceholder.typicode.com/
  
  @IBAction func requestGet(_ sender: Any) {
    print("\n---------- [ Get Method ] ----------\n")
//    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    
  }
  
  
  @IBAction func requestPost(_ sender: Any) {
    print("\n---------- [ Post Method ] ----------\n")
//    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
  }
  
  @IBAction func requestDelete(_ sender: Any) {
    print("\n---------- [ Delete Method ] ----------\n")
//    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
  }
}

