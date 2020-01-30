# Core Location

- 기기의 지리적 위치, 고도, 방향, iBeacon 주변의 상대적 위치 등을 결정하는 서비스를 제공하는 Framework

## Authorization

- 위치 정보를 사용하기 위해 사용자로부터 권한을 얻어야 함

### Info.plist

- `NSLocationWhenInUseUsageDescription` : 앱을 사용하는 동안에만 위치 서비스를 사용할 때
- `NSLocationAlwaysUsageDescription` : 앱이 background 상태일 때에도 위치 서비스를 사용할 때

### Request Authorization

- `CLLocationManager` 인스턴스를 생성해서 권한 요청

- `CLLocationManager.authorizationStatus()` : 현재 위치 서비스 권한 설정 상태를 반환

- `locationManager.requestWhenInUseAuthorization()` : 앱을 사용하는 동안 위치 서비스 사용 권한 요청

- `locationManager.requestAlwaysAuthorization()` : 앱이 항상 위치 서비스를 사용하도록 권한 요청

  ```swift
  let locationManager = CLLocationManager()
  ...
  switch CLLocationManager.authorizationStatus() {
  case .notDetermined:
    // 앱을 처음 실행했을 때는 not determined 상태. 권한을 요청함
    locationManager.requestWhenInUseAuthorization()
  	locationManager.requestAlwaysAuthorization()
  case .restricted, .denied:
    // 위치 서비스 사용을 거부한 경우
  	break
  case .authorizedWhenInUse, .authorizedAlways:
  	// 위치 서비스 사용 권한을 얻은 경우
  }
  ```

- `CLLocationManager` 인스턴스를 생성하거나 권한 요청을 통해 위치 서비스 권한 상태가 변경되는 경우, `CLLocationManagerDelegate`의 `locationManager(_:didChangeAuthorization:)` method가 호출됨. 변경된 status가 들어옴

  ```swift
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .authorizedWhenInUse, .authorizedAlways:
          print("Authorized")
      default:
          print("Unauthorized")
      }
  }
  ```

## Update Location

### Getting User's Location Data

- `locationManager.startUpdatingLocation()` : 사용자의 현재 위치 정보를 갱신

  - `locationManager.desiredAccuracy` : 위치 정보의 정밀도. 기본값 `kCLLocationAccuracyBest`

  - `locationManager.distanceFilter` : 위치 정보 update 이벤트를 발생시키기 위해 필요한 최소 이동 거리를 설정함. `kCLDistanceFilterNone`이 기본값으로, 모든 이동을 감지할 때 마다 update함

    ```swift
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.distanceFilter = 10.0
    ```

- `locationManager.stopUpdatingLocation()` : 위치 정보 갱신을 멈추기

- `locationManager.locationServicesEnabled()` :  위치 서비스를 사용할 수 있는지 확인하기

  ```swift
  func startUpdatingLocation() {
    let status = CLLocationManager.authorizationStatus()
    guard status == .authorizedAlways || status == .authorizedWHenInUse,
    			locationManager.locationServicesEnabled() else { return }
    locationManager.startUpdatingLocation()
  }
  
  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
  }
  ```

- 위치 정보 update 후 `CLLocationManagerDelegate`의 `locationManager(_:didUpdateLocations:)` method가 호출됨. 매개변수로 들어오는 새로운 위치 정보(`location`)를 이용해서 구현

  ```swift
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  	// location이 update 되어야 호출되므로 반드시 하나는 가지고 있음
    guard let current = locations.last else { return }
    
    // 위경도 좌표(CLLocationCoordinate2D)
  	let coordinate = current.coordinate
    
    // location이 생성된 시간
  	let timeStamp = current.timeStamp
    
    /* locations 매개변수는 앱이 재시작되거나 중간에 다른 앱으로 전환되어 위치 서비스 갱신이
    	 멈춘 경우에도 이전에 들어왔던 location 정보들을 캐싱해서 갖고 있음. 오래된 위치 정보는 배제하기 		 위해 최근 location이 생성된 시간과 현재 시간 사이에 걸린 시간이 10초 이내인 것만 사용하는 것
     */
    if abs(timeStamp.timeIntervalSinceNow) < 10 { ... }
  }
  ```

### Updating Heading

- `locationManager.startUpdatingHeading()` : 사용자의 현재 방향 정보를 갱신

- `locationManager.stopUpdatingHeading()` : 방향 정보 갱신을 멈추기

- `locationManager.headingAvailable()` : 방향 정보를 사용할 수 있는지 확인하기

  ```swift
  func startUpdatingHeading() {
    guard locationManager.headingAvailable() else { return }
    locationManager.startUpdatingHeading()
  }
  
  func stopUpdatingHeading() {
    locationManager.stopUpdatingHeading()
  }
  ```

- 방향 정보 update 후 `CLLocationManagerDelegate`의 `locationManager(_:didUpdateHeading:)` method가 호출됨. 매개변수로 들어오는 새로운 방향 정보(`newHeading`)를 사용해서 구현

  ```swift
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    let trueHeading = newHeading.trueHeading					// 진북. 북쪽이 항상 같음
    let magneticHeading = newHeading.magneticHeading	// 자북. 조금씩 바뀜
    let headingX = newHeading.x		// x축 방향
    let headingY = newHeading.y		// y축 방향
    let headingZ = newHeading.z		// z축 방향
  }
  ```

## Represent Location data

- `CLLocation`, `CLLocationCoordinate2D`
- `CLFloor`
- `CLVisit`

### CLLocation

- 시스템으로부터 전달되는 위도, 경도, 고도, 경로(course) 정보를 담고 있는 객체

- 커스텀 위치 정보를 캐싱하거나 두 지점 사이의 거리를 구하는 경우가 아니라면 직접 생성하지 않음

  ```swift
  /* 위치 정보 */
  var coordinate: CLLocationCoordinate2D { get }			// 위경도 좌표
  var altitude: CLLocationDistance { get }						// distanceFilter
  var horizontalAccuracy: CLLocationAccuracy { get }	// desiredAccuracy(H)
  var verticalAccuracy: CLLocationAccuracy { get }		// desiredAccuracy(V)
  var floor: CLFloor? { get }		// Floor Info
  var timestamp: Date { get }		// Location 생성된 시간 정보
  
  /* 좌표 간 거리 */
  func distance(from location: CLLocation) -> CLLocationDistance
  
  /* 속도 및 코스 정보 */
  var course: CLLocationDirection { get }		// 경로 정보
  var speed: CLLocationSpeend { get }				// 속도 정보
  ```

### CLLocationCoordinate2D

- `CLLocation`의 위경도 좌표 정보를 갖는 객체

  ```swift
  /* 좌표 */
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  ```

## Geocoding

- `CLGeocoder`를 이용하여 위경도 좌표와 실제 지명 간에 변환을 처리함.

- `CLPlacemark` : 장소에 대한 정보

- **Geocode** : Plackmark -> Coordinate(지명을 좌표로) 변환. `geocodeAddressString()`

  ```swift
  func geocde(address: String) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) { (placemark, error) in
      guard error == nil else { return }	// error handling
  		guard place = placemark.first? else { return }
  		guard location = place.location? else { return }
    }
  }
  ```

- **Reverse Geocode** : Coordinate -> Placemark(좌표를 지명으로) 변환. `reverseGeocodeLocation()`

  ```swift
  func reverseGeocode(coordinate: CLLocationCoordinate2D) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(coordinate) { (placemark, error) in
  		guard error == nil else { return }	// error handling
  	
  		// 국가별 주소 체계에 따라 다른 값을 가질 수 있음
  		guard let address = placemark?.first,		// 주소 정보
  					let country = address.country,		// 국가명
  					let administrativeArea = address.administrativeArea,	// 시
  					let locality = address.locality,	// 구
  					let name = address.name 					// 동 이하 주소
  		else { return }
  	}
  }
  ```

### 주의

- `CLGeocoder` 객체는 단일 객체로, 하나의 사용자 action에서 하나의 geocoding만 요청해야함
- 일반적인 상황에서는 분당 하나 이상의 geocode 요청을 보내지 말것
- 앱이 Foreground 상태여서 사용자가 결과를 즉시 확인할 수 있을 때만 사용할 것

