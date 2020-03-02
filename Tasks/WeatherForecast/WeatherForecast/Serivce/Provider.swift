//
//  Provider.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

protocol Provider {
  func requestCurrent(lat: Double, lon: Double, completion: @escaping (Result<WeatherCurrent, Error>)->Void)
  func requestShortRange(lat: Double, lon: Double, completion: @escaping (Result<WeatherShortRange, Error>)->Void)
}
