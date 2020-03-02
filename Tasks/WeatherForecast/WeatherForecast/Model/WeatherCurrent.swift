//
//  Weather.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/28.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct WeatherCurrent {
  struct Sky: Decodable {
    let code: String
    let name: String
  }
  struct Temperature: Decodable {
    let tc: String
    let tmax: String
    let tmin: String
  }
  
  let sky: Sky
  let temperature: Temperature 
}

// MARK: Decode current weather

extension WeatherCurrent: Decodable {
  enum CodingKeys: String, CodingKey {
    case weather, common, result
  }
  
  enum WeatherKeys: String, CodingKey {
    case hourly
  }
  
  enum HourlyKeys: String, CodingKey {
    case sky, temperature
  }
    
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let weather = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
    var hourlyArr = try weather.nestedUnkeyedContainer(forKey: .hourly)
    let data = try hourlyArr.nestedContainer(keyedBy: HourlyKeys.self)
    
    self.sky = try data.decode(Sky.self, forKey: .sky)
    self.temperature = try data.decode(Temperature.self, forKey: .temperature)
  }
}

// MARK:- Debugging

extension WeatherCurrent: CustomStringConvertible {
  var description: String {
    """
    * Sky
      - code : \(self.sky.code)
      - name : \(self.sky.name)
    * Temperature
      - current : \(self.temperature.tc)
      - max : \(self.temperature.tmax)
      - min : \(self.temperature.tmin)
    """
  }
}
