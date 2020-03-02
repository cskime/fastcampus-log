//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by cskim on 2020/03/01.
//  Copyright © 2020 cskim. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
  typealias Location = CLLocation
  func locationManager(_ manager: LocationManager, didReceiveAddress address: String?)
  func locationManager(_ manager: LocationManager, didReceiveLocation location: Location)
}

class LocationManager: NSObject {
  private let manager = CLLocationManager()
  private var latestUpdateDate = Date(timeIntervalSinceNow: -10)
  weak var delegate: LocationManagerDelegate?

  override init() {
    super.init()
    self.manager.delegate = self
    self.checkAuthorization()
  }
  
  private func checkAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      self.manager.requestWhenInUseAuthorization()
    case .authorizedAlways, .authorizedWhenInUse:
      break
    default:
      break
    }
  }
  
  func startUpdatingLocation() {
    self.manager.startUpdatingLocation()
  }
}

// MARK:- CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      self.manager.startUpdatingLocation()
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    manager.stopUpdatingLocation()
    
    // 2초 뒤 location만 사용. 연속 2~3회 updating 대비
    if abs(self.latestUpdateDate.timeIntervalSince(location.timestamp)) > 2 {
      self.reverseGeocodeLocation(location)
      self.delegate?.locationManager(self, didReceiveLocation: location)
      self.latestUpdateDate = location.timestamp
    }
  }
  
  private func reverseGeocodeLocation(_ location: CLLocation) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      guard error == nil else { return print(error!.localizedDescription) }
      guard let placemark = placemarks?.first else { return }
      
      if let locality = placemark.locality, let subLocality = placemark.subLocality ?? placemark.thoroughfare {
        self.delegate?.locationManager(self, didReceiveAddress: locality + " " + subLocality)
      } else {
        self.delegate?.locationManager(self, didReceiveAddress: nil)
      }
    }
  }
}
