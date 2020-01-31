//
//  Logger.swift
//  CustomLogExample
//
//  Created by giftbot on 2020/01/30.
//  Copyright © 2020 giftbot. All rights reserved.
//

import Foundation

class Formatter {
  static let date: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss:SSS"
    return dateFormatter
  }()
}

func logger(
  _ contents: Any...,
  header: String = "",
  _ file: String = #file,
  _ function: String = #function,
  _ line: Int = #line
)  {
  let emoji = "😀"
  let timestamp = Formatter.date.string(from: Date())
  
  // 긴 path에서 파일 이름만 추리는 작업
  let fileUrl = URL(fileURLWithPath: file)
  let fileName = fileUrl.deletingPathExtension().lastPathComponent
  
  let header = header.isEmpty ? "" : " [ \(header) ] "
  let content = contents.reduce("") { $0 + " " + String(describing: $1) }
  
  let combineStr = """
  \(emoji) \(timestamp) / \
  \(fileName) / \(function) (\(line)) \(emoji) \
  \(header)\(content)
  """
  print(combineStr)
}
