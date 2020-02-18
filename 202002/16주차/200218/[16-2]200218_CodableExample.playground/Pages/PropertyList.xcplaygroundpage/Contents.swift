//: [Previous](@previous)
/*:
 # PropertyList
 */

import Foundation

struct MacBook: Codable {
  let model: String
  let modelYear: Int
  let display: Int
}

let macBook = MacBook(
  model: "MacBook Pro", modelYear: 2018, display: 15
)

// Codable 이전 - PropertyListSerialization
// Codable 이후 - PropertyListEncoder / PropertyListDecoder

// PropertyList : XML을 위해

/*:
 ---
 ## Encoder
 ---
 */
print("\n---------- [ Encoder ] ----------\n")
let pListEncoder = PropertyListEncoder()
let encodedMacBook = try! pListEncoder.encode(macBook)
print(encodedMacBook)

let appSupportDir = FileManager.default.urls(
  for: .documentDirectory, in: .userDomainMask
  ).first!
let archiveURL = appSupportDir
  .appendingPathComponent("macBookData")  // 파일 이름
  .appendingPathExtension("plist")        // 확장자

try? encodedMacBook.write(to: archiveURL)


/*:
 ---
 ## Decoder
 ---
 */
print("\n---------- [ Decoder ] ----------\n")
let pListDecoder = PropertyListDecoder()
if let decodedMacBook = try? pListDecoder.decode(MacBook.self, from: encodedMacBook) {
  print(decodedMacBook) // Tag 등 때문에 string이 더 많으므로 byte가 더 높음
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedMacBook = try? pListDecoder.decode(MacBook.self, from: retrievedData) {
  print(retrievedData)
  print(decodedMacBook)
}



/*:
 ---
 ### Question
 - MacBook 타입을 Array, Dictionary 형태로 Encoding / Decoding 하려면?
 ---
 */
let myArr = [macBook, macBook, macBook]
let myEncodedArr = try! PropertyListEncoder().encode(myArr)
let myDecodedArr = try! PropertyListDecoder().decode([MacBook].self, from: myEncodedArr)


let myDic = ["mac": macBook, "mac1": macBook, "mac2": macBook]
let myEncodedDic = try! PropertyListEncoder().encode(myDic)
print(myEncodedDic)

let myDecodedDic = try! PropertyListDecoder().decode([String: MacBook].self, from: myEncodedDic)
print(myDecodedDic)


/*:
 ---
 ### Answer
 ---
 */
// Array
print("\n---------- [ Array ] ----------\n")
let arr = [macBook, macBook, macBook]

let encodedArr = try! pListEncoder.encode(arr)  // Encode: Array -> Data
try? encodedArr.write(to: archiveURL)           // File write

// Decode: Data -> Array
if let decodedArr = try? pListDecoder.decode([MacBook].self, from: encodedArr) {
  print(decodedArr)
}

// Decode From File
// File -> Data -> Array
if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedArr = try? pListDecoder.decode([MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedArr)
}



// Dictionary
print("\n---------- [ Dictionary ] ----------\n")
let dict = ["mac": macBook, "mac1": macBook, "mac2": macBook]

let encodedDict = try! pListEncoder.encode(dict)  // Encode: Dict -> Data
try? encodedDict.write(to: archiveURL)            // File Write

// Decode: Data -> Dict
if let decodedDict = try? pListDecoder.decode([String: MacBook].self, from: encodedDict) {
  print(decodedDict)
}

// Decode From File
// File -> Data -> Dict
if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedDict = try? pListDecoder.decode([String: MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedDict)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
