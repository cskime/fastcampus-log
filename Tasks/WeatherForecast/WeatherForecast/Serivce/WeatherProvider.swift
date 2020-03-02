//
//  WeatherProvider.swift
//  WeatherForecast
//
//  Created by cskim on 2020/03/01.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

class WeatherProvider: Provider {
  private let appKey = "l7xx1f8d7578e5b64b78a97e0a6011ec5059"
  private let baseURL = "https://apis.openapi.sk.com"
  private let currentPath = "/weather/current/hourly?"
  private let shortRangePath = "/weather/forecast/3days?"
  
  func requestCurrent(lat: Double = 0, lon: Double = 0, completion: @escaping (Result<WeatherCurrent, Error>) -> Void) {
    let stringURL = self.baseURL.append(self.currentPath)
      .addQuery(key: .appKey, value: self.appKey)
      .addQuery(key: .version, value: "2")
      .addQuery(key: .lat, value: String(lat))
      .addQuery(key: .lon, value: String(lon))
      .dropLast()
    print("Current URL :", stringURL)
    guard let url = URL(string: String(stringURL)) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return completion(.failure(error!)) }
      guard let response = response as? HTTPURLResponse else { return print("Fail to receive response") }
      guard (200..<300).contains(response.statusCode) else { return print("Invalid Response. Status Code \(response.statusCode)") }
      guard let data = data else { return print("Invalid Data") }
      
      do {
        let data = try JSONDecoder().decode(WeatherCurrent.self, from: data)
        completion(.success(data))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
  
  func requestShortRange(lat: Double, lon: Double, completion: @escaping (Result<WeatherShortRange, Error>) -> Void) {
    let stringURL = self.baseURL.append(self.shortRangePath)
    .addQuery(key: .appKey, value: self.appKey)
    .addQuery(key: .version, value: "2")
    .addQuery(key: .lat, value: String(lat))
    .addQuery(key: .lon, value: String(lon))
    .dropLast()
    
    guard let url = URL(string: String(stringURL)) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return completion(.failure(error!)) }
      guard let response = response as? HTTPURLResponse else { return print("Fail to receive response") }
      guard (200..<300).contains(response.statusCode) else { return print("Invalid Response. Status Code \(response.statusCode)") }
      
      guard let data = data else { return print("Invalid Data") }
      do {
        let data = try JSONDecoder().decode(WeatherShortRange.self, from: data)
        completion(.success(data))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}

extension String {
  func append(_ string: String) -> Self {
    return self + string
  }
  
  enum QueryKeys: String {
    case appKey
    case version
    case lat
    case lon
  }
  func addQuery(key: QueryKeys, value: String) -> Self {
    return self + "\(key)=\(value)&"
  }
}
