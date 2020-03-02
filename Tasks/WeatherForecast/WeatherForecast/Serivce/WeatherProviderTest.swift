//
//  WeatherProviderTest.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

class WeatherProviderTest: Provider {
  func requestCurrent(lat: Double = 0, lon: Double = 0, completion: @escaping (Result<WeatherCurrent, Error>) -> Void) {
    guard let jsonData = TestData.current else { return }
    do {
      let data = try JSONDecoder().decode(WeatherCurrent.self, from: jsonData)
      completion(.success(data))
    } catch {
      completion(.failure(error))
    }
  }
  
  func requestShortRange(lat: Double, lon: Double, completion: @escaping (Result<WeatherShortRange, Error>) -> Void) {
    guard let jsonData = TestData.shortRange else { return }
    do {
      let data = try JSONDecoder().decode(WeatherShortRange.self, from: jsonData)
      completion(.success(data))
    } catch {
      completion(.failure(error))
    }
  }
}
