//: [Previous](@previous)
import Foundation
//: - - -
//: # Creating JSON Data
//: * class func isValidJSONObject(_:) -> Bool
//: * class func writeJSONObject(_:to:options:error:) -> Int
//: * class func data(withJSONObject:options:) throws -> Data
//: - - -

//: ---
//: ## Write JSON Object to OutputStream
//: ---
// Foundation 객체 -> 파일 저장



func writeJSONObjectToOutputStream() {
  let jsonObject = ["hello": "world", "foo": "bar", "iOS": "Swift"]
  guard JSONSerialization.isValidJSONObject(jsonObject) else { return }
  
  let jsonFilePath = "myJsonFile.json"
  let outputJSON = OutputStream(toFileAtPath: jsonFilePath, append: false)! // append: 같은 파일 있을 때 이어서 쓸 것인지 새로 만들 것인지
  outputJSON.open() // 파일열기
  
  // 파일 쓰기
  // options
  //  - .prrettyPrinted : 용량 최적화를 위해 한줄로 출력되던 string을 읽기 편한 형태로 데이터를 구성함
  //  - .sortedKeys : key값을 정렬해서 데이터를 구성함

  let writtenBytes = JSONSerialization.writeJSONObject(
    jsonObject,
    to: outputJSON,
    options: [],
//    options: [.prettyPrinted, .sortedKeys],
    error: nil
  )
  print(writtenBytes)  // 0 = error
  outputJSON.close()  // 파일 닫기
  
  // File로부터 JOSN Data 읽어오기
  do {
    let jsonString = try String(contentsOfFile: jsonFilePath)
    let data = jsonString.data(using: .utf8)!
    let jsonObject = try! JSONSerialization.jsonObject(with: data) as! [String: String]
    print(jsonString)
    print(jsonObject)
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ writeJSONObjectToOutputStream ] ----------\n")
writeJSONObjectToOutputStream()

//: ---
//: ## Data with JSON Object
//: ---
// Foundation 객체 -> JSON 형식 데이터

private func dataWithJSONObject() {
  let jsonObject: [String: Any] = [
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3],
    "someDict"   : [
      "someBool" : true
    ]
  ]
  
  guard JSONSerialization.isValidJSONObject(jsonObject) else { return }
  do {
    // 딕셔너리를 데이터로 인코딩했다가 다시 데이터를 통해 딕셔너리로 변환해보는 과정
    let encoded = try JSONSerialization.data(withJSONObject: jsonObject)  // JSON object -> data
    let decoded = try JSONSerialization.jsonObject(with: encoded)         // data -> JSON Object
    
    print(encoded)
    if let jsonDict = decoded as? [String: Any] {
      print(jsonDict)
    }
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ dataWithJSONObject ] ----------\n")
dataWithJSONObject()



//: - - -
//: # Creating a JSON Object
//: * class func jsonObject(with:options:) throws -> Any
//: - - -

//: ---
//: ## JSON Object with Data
//: ---
// JSON 형식 데이터 -> Foundation 객체

private func jsonObjectWithData() {
  let jsonString =  """
  {
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3, 4],
    "someDict"   : {
      "someBool" : true
    }
  }
  """
//  let jsonString = """
//     { "hello": "world", "foo": "bar", "iOS": "Swift" }
//  """
  let jsonData = jsonString.data(using: .utf8)! // string -> data

  do {
    let foundationObject = try JSONSerialization.jsonObject(with: jsonData) // data -> JSON object
    if let jsonDict = foundationObject as? [String: Any] {
      print(jsonDict)
    }
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ jsonObjectWithData ] ----------\n")
jsonObjectWithData()



//: ---
//: ## JSON Object with InputStream
//: ---
private func jsonObjectWithInputStream() {
  let jsonFilePath = "myJsonFile.json"
  let inputStream = InputStream(fileAtPath: jsonFilePath)!  // file 열어서 내용을 읽어옴
  inputStream.open()
  defer { inputStream.close() }
  
  guard inputStream.hasBytesAvailable else { return }
  
  do {
    let jsonObject = try JSONSerialization.jsonObject(with: inputStream)
    print(jsonObject)
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ jsonObjectWithInputStream ] ----------\n")
jsonObjectWithInputStream()


//: [Next](@next)
