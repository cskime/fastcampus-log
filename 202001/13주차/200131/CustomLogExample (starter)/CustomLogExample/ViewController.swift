//
//  ViewController.swift
//  CustomLogExample
//
//  Created by giftbot on 2020/01/30.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  private let dog = Dog()
  private let cat = Cat()
  
//  override var description: String {
//    return "ViewController"
//  }
//  
//  override var debugDescription: String {
//    return "ViewController Debug"
//  }
  
  @IBAction private func didTapPrint(_ sender: Any) {
    print("\n---------- [ print ] ----------\n")
    print("Hello, world!")
    print(1...10)
    print(dog)
    print(cat)
    print(self)
  }
  
  @IBAction private func didTapDebugPrint(_ sender: Any) {
    print("\n---------- [ debugPrint ] ----------\n")
    debugPrint("Hello, world!")
    debugPrint(1...10)
    debugPrint(dog)
    debugPrint(cat)
    debugPrint(self)
  }
   
  @IBAction private func didTapDump(_ sender: Any) {
    print("\n---------- [ dump ] ----------\n")
    dump("Hello, world!")
    dump(1...10)
    dump(dog)
    dump(cat)
    dump(self)
  }
  
  @IBAction private func didTapNSLog(_ sender: Any) {
    print("\n---------- [ NSLog ] ----------\n")
    NSLog("Hello, world!")
    NSLog("%@", self)
  }
  
  @IBAction private func didTapSpecialLiterals(_ sender: Any) {
    print("\n---------- [ didTapSpecialLiterals ] ----------\n")
    /*
     #file : (String) 파일 이름
     #function : (String) 함수 이름
     #line : (Int) 라인 넘버
     #culumn : (Int) 컬럼 넘버
     */
    
    print(#file)
    print(#function)
    print(#line)
    print(#column)
  }
  
  @IBAction private func didTapCustomLog(_ sender: Any) {
    print("\n---------- [ Custom Log ] ----------\n")
    logger("Hello, world!", header: "Too Hard")
    logger(dog)
    logger(cat)
    logger(self)
  }
  
  @IBAction private func didTapTestButton(_ sender: Any) {
    print("\n---------- [ Test ] ----------\n")
    // 테스트용 버튼
  }
}



