# Weather Forecast

- Weather API를 사용한 음악 검색 앱
- 사용 API : SK Weather Planet

## Codable

- `Codable`을 이용한 JSON format의 API 를 파싱할 때, dictionary를 여러개 갖는 배열에 대해서 `nestedUnkeyedContainer(forKey:)`를 사용하여 해당 배열을 container로 가져올 수 있다.

- Unkeyed container에서 각 element(dictionary)를 decoding하려면 container가 가진 Element 개수만큼 decode를 반복한다.

    - JSON Data
    
      ```swift
      let jsonData =
        """
        {
          "weather": {
            "hourly": [
              {
                "grid": {
                  "latitude": "36.10499",
                  "longitude": "127.13747",
                  "city": "충남",
                  "county": "논산시",
                  "village": "가야곡면"
                },
                "sky": {
                  "code": "SKY_O01",
                  "name": "맑음"
                },
                "temperature": {
                  "tc": "11.10",
                  "tmax": "11.00",
                  "tmin": "1.00"
                },
                "humidity": "50.00",
                "lightning": "0",
                "wind": {
                  "wdir": "325.00",
                  "wspd": "1.90"
                },
                "precipitation": {
                  "sinceOntime": "0.00",
                  "type": "0"
                },
                "sunRiseTime": "2020-02-27 07:05:00",
                "sunSetTime": "2020-02-27 18:24:00",
                "timeRelease": "2020-02-27 13:00:00"
              }
            ]
          },
        }
        """.data(using: .utf8)
      ```
    
    - skyCode, skyName, temperature를 가져오기 위한 codable object
    
      ```swift
      struct Weather {
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
      
      ```

## UITableView

### Subclass from UIScrollView

- `UITableView`는 `UIScrollView`의 subclass

- `UIScrollView`의 `contentInset` 속성을 사용하여 `UITableView`의 cell이 나타나는 시작지점 조절 가능

  ```swift
  // tableView의 content가 나타나는 지점을 offset만큼 아래로 설정
  tableView.contentInset = UIEdgeInset(top: offset, 
                                       left: 0,
                                       bottom: 0,
                                       right: 0)
  ```

### Delegate

- `UITableViewDelegate`을 통해 `UIScrollViewDelegate`도 구현할 수 있다.

  ```swift
  extension ViewController: UITableViewDelegate {
  	// UIScrollViewDelegate에서 선언된 method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      // scrollView에 실제로 들어있는 인스턴스는 UITableVIew
      let inset = scrollView.contentInset.top
      let offset = scrollView.contentOffset.y
      let alpha = 1 + offset / inset
      
      // Scroll하면서 offset 위치에 따라 배경 투명도 및 수평이동 motion 조정
      self.backgroundView.updateBlurView(alpha: min(0.8, alpha))
      self.backgroundView.updateParallazEffect(transitionX: 30 * min(1, alpha))
    }
  }
  ```

## CoreLocation

- `CoreLocation`에서 사용자 위치 정보를 update할 때, gps 오차 등 요인으로 인해 location을 연속으로 2~3번 update하는 경우가 발생함. 

- 이 문제를 해결하기 위해 `timeStamp`를 사용하여 마지막으로 location을 update한 시간으로부터 일정 시간이 지난 후 새로운 location을 update하도록 제한

  ```swift
  func locationManager(_ manager: CLLocationManager, 
                       didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
  	// 위치를 update한 뒤 곧 바로 update를 종료해도 2~3번 연속으로 update하는 문제
    manager.stopUpdatingLocation()
  
    // 2초 뒤 location만 사용하도록 제한
    if abs(self.latestUpdateDate.timeIntervalSince(location.timestamp)) > 2 {
      self.reverseGeocodeLocation(location)
      self.delegate?.locationManager(self, didReceiveLocation: location)
      self.latestUpdateDate = location.timestamp
    }
  }
  ```

  