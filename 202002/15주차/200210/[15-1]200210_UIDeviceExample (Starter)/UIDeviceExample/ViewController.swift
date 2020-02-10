//
//  ViewController.swift
//  UIDeviceExample
//
//  Created by giftbot on 2020/01/28.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

/***************************************************
 UIDevice
 - 디바이스 이름 / 모델 / 화면 방향 등
 - OS 이름 / 버전
 - 인터페이스 형식 (phone, pad, tv 등)
 - 배터리 정보
 - 근접 센서 정보
 - 멀티태스킹 지원 여부
 ***************************************************/


final class ViewController: UIViewController {
  
  @IBOutlet private weak var label: UILabel!
  let device = UIDevice.current   // UIDevice instance 접근. Singleton
  let notiCenter = NotificationCenter.default
  
  @IBAction private func systemVersion() {
    print("\n---------- [ System Version ] ----------\n")
    
    print("System Name :", device.systemName)
    let systemVersion = device.systemVersion
    print("System Version :", systemVersion)
    label.text = systemVersion
    
    let splitVersion = systemVersion.split(separator: ".").compactMap { Int($0) }
    print(splitVersion)
  }
  
  @IBAction private func architecture() {
    print("\n---------- [ Architecture ] ----------\n")
    
    #if DEBUG
    // Scheme에서 Run, Profile, Achieve할 때 Debug, Release flag에 따라 코드 실행을 나눌 수 있음
    #endif
    
    
    #if targetEnvironment(simulator)  // 디버깅 목적의 환경변수를 이용할 때 (#if #else #endif)
    print("Simulator")
    label.text = "Simulator"
    #else
    print("Device")
    label.text = "Device"
    #endif
    
    print("TARGET_OS_IPHONE : ", TARGET_OS_IPHONE)
    print("TARGET_OS_IOS : ", TARGET_OS_IOS)              // 1: true. target os가 IOS인지 확인
    print("TARGET_OS_SIMULATOR : ", TARGET_OS_SIMULATOR)  // Simulator인지 확인
    print("TARGET_CPU_X86 : ", TARGET_CPU_X86)            //
    print("TARGET_CPU_X86_64 : ", TARGET_CPU_X86_64)      //
    print("TARGET_CPU_ARM : ", TARGET_CPU_ARM)
    print("TARGET_CPU_ARM64 : ", TARGET_CPU_ARM64)
  }
  
  @IBAction private func deviceModel() {
    print("\n---------- [ Device Model ] ----------\n")
    
    print("name :", device.name)    // 설정에서 입력한 device 이름
    print("model :", device.model)  // 현재 device 모델 이름
    print("localicedModel :", device.localizedModel)
    print("userInterfaceIdiom :", device.userInterfaceIdiom)
    print("orientation :", device.orientation)  // 화면 방향
    print("isMultitaskingSupported :", device.isMultitaskingSupported)  // 일반적으로 거의 true
    
    // extension
    
    print("modelIdentifier :", device.identifier)
    print("modelName :", device.modelName)
    label.text = "\(device.identifier): \(device.modelName)"
    print(device.simulatorModelName)
  }
  
  
  // MARK: - Battery
  
  @IBAction private func battery() {
    print("\n-------------------- [ Battery Info ] --------------------\n")
    
    /*
     public enum UIDeviceBatteryState: Int {
       case unknown
       case unplugged   // on battery, discharging
       case charging    // plugged in, less than 100%
       case full        // plugged in, at 100%
     }
     */
    
    print("batteryState :", device.batteryState)  // unknown, unplugged, charge, full
    print("batteryLevel :", device.batteryLevel)  // 0 ~ 1.0. Unknown이면 -1.0
    
    print("isBatteryMonitoringEnabled :", device.isBatteryMonitoringEnabled)
    label.text = "\(device.batteryState) : \(device.batteryLevel)"
  }
  
  @IBAction private func batteryMonitoring(_ sender: UIButton) {
    print("\n---------- [ batteryMonitoring ] ----------\n")
    sender.isSelected.toggle()
    device.isBatteryMonitoringEnabled.toggle()
    
    if device.isBatteryMonitoringEnabled {
      notiCenter.addObserver(
        self,
        selector: #selector(didChangeBatteryState(_:)),
        name: UIDevice.batteryStateDidChangeNotification,
        object: nil)
    } else {
      notiCenter.removeObserver(self, name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
  }
  
  @objc func didChangeBatteryState(_ noti: Notification) {
    guard let device = noti.object as? UIDevice else { return }
    print("batteryState :", device.batteryState)  // unknown, unplugged, charge, full
    print("batteryLevel :", device.batteryLevel)  // 0 ~ 1.0. Unknown이면 -1.0
  }
  
  
  // MARK: - Proximity State
  
  @IBAction private func proximityMonitoring(_ sender: UIButton) {
    print("\n-------------------- [ Proximity Sensor ] --------------------\n")
    // 근접센서. 가까이 다가가면 화면이 꺼지고 멀어지면 다시 켜짐
    // 전화받을 때 등
    
    sender.isSelected.toggle()
    device.isProximityMonitoringEnabled.toggle()
    print("ProximityMonitoring :", device.isProximityMonitoringEnabled)
    
    if device.isProximityMonitoringEnabled {
      notiCenter.addObserver(
        self,
        selector: #selector(didChangeProximityState(_:)),
        name: UIDevice.proximityStateDidChangeNotification,
        object: nil)
    } else {
      notiCenter.removeObserver(self, name: UIDevice.proximityStateDidChangeNotification, object: nil)
    }
  }
  
  @objc func didChangeProximityState(_ noti: Notification) {
    print(UIDevice.current.proximityState)
    label.text = "\(UIDevice.current.proximityState)"
  }
  
  
  // MARK: - Orientation Notification
  
  @IBAction private func beginOrientationNotification() {
    device.beginGeneratingDeviceOrientationNotifications()  // count가 중첩되는 형태. 세번 실행하면 카운트가 3 쌓여서 end도 3번 해줘야함.
    print(device.isGeneratingDeviceOrientationNotifications)
    label.text = "\(device.isGeneratingDeviceOrientationNotifications)"
    
    notiCenter.addObserver(
      self,
      selector: #selector(orientationDidChange(_:)),
      name: UIDevice.orientationDidChangeNotification,
      object: nil)
  }
  
  @objc func orientationDidChange(_ noti: Notification) {
    print("\n-------------------- [ Orientation didChange ] --------------------\n")
    
    if let device = noti.object as? UIDevice {
      print("Device Orientation :", device.orientation)   // 디바이스가 움직이는 방향 그대로 나타냄
    }
    
    // SceneDelegate가 생겼을 때 기준
    if #available(iOS 13.0, *) {
      let scene = UIApplication.shared.connectedScenes.first
      let orientation = (scene as! UIWindowScene).interfaceOrientation
      print("Interface Orientation :", orientation)   // 디바이스 상단을 기준으로 status bar가 나타나는 방향. Status bar 기준으로 content 표시
    } else {
      let orientation = UIApplication.shared.statusBarOrientation
      print("StatusBar Orientation :", orientation)
      print(orientation.isPortrait)
      print(orientation.isLandscape)
    }
    
    // device orientation이 portraitUpsideDown일 때 interface orientation 은 반응하지 않음
    // Project Setting에서 설정한 device orientation과 대응됨
    // 노치가 있는 기기에서는 interface orientation에서 upsideDown이 적용되지 않음.
    
    // ViewController마다 다른 interface 적용 가능
  }
  
  @IBAction private func endOrientationNotification() {
    // beginGeneratingDeviceOrientationNotificattions 호출 횟수만큼 반복
    while device.isGeneratingDeviceOrientationNotifications {
      device.endGeneratingDeviceOrientationNotifications()
      print("isGeneratingDeviceOrientationNoti :", device.isGeneratingDeviceOrientationNotifications)
    }
    
    notiCenter.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    label.text = "\(device.isGeneratingDeviceOrientationNotifications)"
  }
  
  // MARK: Notification
  
  func asdf() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShowNotification(_:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShowNotification(_:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
    
    UIResponder.keyboardWillHideNotification
    UIResponder.keyboardDidHideNotification
    
    UIResponder.keyboardWillShowNotification
    UIResponder.keyboardDidShowNotification
    
    UIResponder.keyboardWillChangeFrameNotification
    UIResponder.keyboardDidChangeFrameNotification
  }
  
  @objc private func keyboardWillShowNotification(_ noti: Notification) {
    guard let userInfo = noti.userInfo,
      let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
      let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
      else { return }
    
    // 키보드 크기를 정확하게 알아내는 방법. 사용자마자 키보드 높이가 달라질 수 있는 것에 대응
    // 키보드 나타날 때 frame과 키보드 올라오는 애니메이션의 duration을 알아내서 가리는 view들도 그만큼 올려준다
    
  }
  
}





