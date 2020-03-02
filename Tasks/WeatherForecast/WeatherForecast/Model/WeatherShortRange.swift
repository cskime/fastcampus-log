//
//  WeatherShortRange.swift
//  WeatherForecast
//
//  Created by cskim on 2020/02/29.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct WeatherShortRange {
  struct ShortRange: CustomStringConvertible {
    let skyCode: String
    let temperature: String
    let date: Date
    
    var description: String {
      """
      * ShortRange
        - skyCode : \(self.skyCode)
        - temperature : \(self.temperature)
        - date : \(self.date)
      """
    }
  }
  let shortRanges: [ShortRange]
}

// MARK:- Decode short range weather

extension WeatherShortRange: Decodable {
  enum CodingKeys: String, CodingKey {
    case weather, common, result
  }
  
  enum WeatherKeys: String, CodingKey {
    case forecast3days
  }
  
  enum Forecast3DaysKeys: String, CodingKey {
    case grid, timeRelease, fcst3hour, fcst6hour, fcstdaily
  }
  
  enum Fcst3HourKeys: String, CodingKey {
    case wind, precipitation, sky, temperature, humidity
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let weather = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
    var forecastArr = try weather.nestedUnkeyedContainer(forKey: .forecast3days)
    let forecast = try forecastArr.nestedContainer(keyedBy: Forecast3DaysKeys.self)
    let fcst3hour = try forecast.nestedContainer(keyedBy: Fcst3HourKeys.self, forKey: .fcst3hour)
    
    let skys = try fcst3hour.decode([String: String].self, forKey: .sky)
    let temps = try fcst3hour.decode([String: String].self, forKey: .temperature)
    let timeRelease = try forecast.decode(String.self, forKey: .timeRelease)
    
    var shortRanges = [ShortRange]()
    stride(from: 4, to: 67, by: 3)
      .forEach {
        guard let skyCode = skys["code\($0)hour"], !skyCode.isEmpty, let temp = temps["temp\($0)hour"] else { return }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let releaseDate = formatter.date(from: timeRelease)
        
        guard let forecastDate = releaseDate?.addingTimeInterval(TimeInterval($0) * 3600) else { return }
        shortRanges.append(ShortRange(skyCode: skyCode, temperature: temp, date: forecastDate))
    }
    self.shortRanges = shortRanges
  }
}

// MARK:- Debugging

extension WeatherShortRange: CustomStringConvertible {
  var description: String {
    var log = ""
    self.shortRanges.enumerated().forEach {
      log += "Element \($0.offset)\n"
      log += "\($0.element)\n"
    }
    return log
  }
}
