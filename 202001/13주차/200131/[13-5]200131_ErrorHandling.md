# Error Handling

## Swift Errors

- Simple Domain Error : 명백하게 실패하는 연산을 실행했을 때 발생할 수 있는 오류. **Optional**로 모델링 되어 있음
- Recoverable : 복잡한 연산 도중 발생할 수 있는 실패 중 사전에 미리 오류를 예측할 수 있는 작업(네트워크 연결, 파일 읽기/쓰기 등). 오류가 발생했을 때 사용자에게 알려주거나, 코드로 별도의 처리를 하도록 함
- Universal Error : 시스템이나 다른 요인에 의한 오류. 어디서 발생하는지 예측하기 어려움
- Logic Failure : 프로그래머 실수에 의한 오류. 프로그램적으로 컨트롤 할 수 없으므로 exception 오류 발생

## Error Handling

- Error Handling : 프로그램 동작 중 예상 가능한 오류가 발생했을 때, 이를 감지하고 복구하기 위한 처리 과정
- Four ways to handle errors

### Propagating Errors Using Throwing Functions

-  Error 처리를 코드의 다른 부분에서 처리하는 것

- 반환 타입 전에 `throws` 키워드를 선언하면 함수 안에서 발생한 error를 해당 함수를 호출한 곳에서(밖에서) 처리하도록 함

  ```swift
  func throwError() throws { 
    try "Swift".write(
      toFile: filePath,
      atomically: true,
      encoding: .utf8
    )
  }
  ```

- `throws` 위치에 따라 모두 다른 타입으로 간주

  ```swift
  let a: () -> () -> ()								
  let b: () throws -> () -> ()				
  let c: () -> () throws -> ()				
  let d: () throws -> () throws -> ()	
  ```

- Non-throws function을 throws function에 넣을 수 있지만, 반대는 안됨(throws function > non throws function)

  ```swift
  func nonThrowsFunction() -> Int { }
  func exampleFunction(_ throwsFunction: () throws -> Int)
  exampleFunction(nonThrowsFunction)		// non-throws를 throws 타입에 전달 가능
  
  func throwsFunction() throws -> Int { }
  func exampleFunction(_ throwsFunction: () -> Int)
  exampleFunction(throwsFunction)		// throws를 non-throws 타입에 넣을 수 없음
  ```
  
-  `throws` method에서는 `throw`를 통해 직접 error를 던지거나 `thorws` method에 대해 `do-catch` 없이 단순히 `try`만을 사용할 수도 있음

   ```swift
   func throwError() throws {
     // do-catch 없이 try만 실행하고 그 결과가 반환되어
     // try throwError()의 실행 결과로 전달됨
     try String(contentsOfFile: tmpDir)
   
     // Error를 직접 throw하여 밖에서 error를 처리하도록 함
     if condition {
       throw MyError.errorWithParam(num: -1)
     }
   }
   
   func nonThrowsFunction() {
     do {
       try throwError()
     } catch {
       print("Error :", error)
       print("=====")
       print("Error Description :", error.localizedDescription)
     }
   }
   ```

### Handling Errors Using Do-Catch

- `do-catch` 구문을 사용한 error handling

- `try`를 사용하여 `throws` method를 처리

- 여러 개의 `try` 중 error가 발생하면 그 순간 `catch`로 실행 흐름이 전달되고 그 아래 코드는 실행되지 않음

  ```swift
  do {
    try expression
    statements
  } catch {
    error handling
  } catch pattern1 { 
    error handling 1
  } catch pattern2 where condition {
    error handling 2
  }
  ```

- `catch`에서 받는 특정 pattern이 없다면 `Error` protocol 타입의 `error` 속성을 기본으로 사용할 수 있음

  - `error.localizedDescription` : `Error` protocol에서 제공하는 자동으로 생성되는 error에 대한 설명

### Converting Errors to Optional Values

- `try?`를 사용하여 `do-catch` 구문 없이 error handling. Error 발생 시 `nil` 반환

  ```swift
  func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
  }
  ```

### Disabling Error Propagation

- `try!`를 사용하여 `throws` method를 처리하고, error가 발생하면 crash
- 오류가 발생하지 않을 것이라고 확신할 수 있는 경우 사용함

## Specifying Cleanup Actions

### defer

- 현재 코드 블럭이 종료되기 직전에 반드시 실행되어야 하는 code block

- 함수가 실행되면서 `defer` block을 **등록해 두고** 해당 범위가 종료될 때 까지 실행을 연기해 뒀다가 **기록된 순서의 역순으로 동작**(역순으로 실행되므로 **stack 구조**의 어딘가에 defer 안에 실행 구문들이 쌓이는 것으로 추측할 수 있음)

  ```swift
  func throwError() throws {
    throw NSError(domain: "Domain", code: 1, userInfo: nil)
  }
  func deferExample() {
    /*
     문자열 출력 순서
     1) do 문에서 오류가 발생했을 때 : 2->3->1
     2) do 문에서 오류가 발생하지 않았을 때 : 2->5->4->1
     */
    defer { print("1) First defer") }
    
    do {
      print("2) Do")
      try throwError()
    } catch {
      return print("3) Error :", error)
    }
    defer { print("4) Second defer") }
    print("5) Last Print")
  }
  deferExample()
  ```

## Custom Error

### Error and NSError

- Swift에서 `Error` protocol을 사용. Objective-C에서 `NSError` 클래스를 사용하던 것에 `Error` protocol을 채택

  ```swift
  // In Swift
  public protocol Error { }
  
  // In Objective-C
  open class NSError: NSObject, NSCopying, NSSecureCoding { }
  extension NSError: Error { }
  ```

- `NSError`는 기본 생성자가 아닌 `NSError(domain:code:userInfo:)`로 생성해야 함

- `catch`에서 제공되는 `error` 속성은 swift의 `error`이므로, `domain`, `code`, `userInfo` 등 속성을 사용하기 위해서는 `NSError`로 캐스팅해야함

  ```swift
  func throwNSError() throws {
    // NSError() - 기본 생성자 (X),  Domain cannot be nil
    throw NSError(domain: "Domain error string", 
                  code: 99, 
                  userInfo: ["MyKey": "MyValue"])
  }
  
  func throwsNSErrorExample() {
    do {
      try throwNSError()
    } catch {
      print("Error :", error)			// Swift의 error(Error)
      
      let e = error as NSError		// NSError
      print("NSError :", e)
      print("domain :", e.domain)
      print("code :", e.code)
      print("userInfo :", e.userInfo)
    }
  }
  ```

### Define Custom Error

- `Error` protocol을 채택하는 `enum` 정의

-  Error를 명확하게 정의해 두고 다룰 수 있도록 interface를 제공하느 것이 좋음

  ```swift
  enum IntParsingError: Error {
    case overflow
    case invalidInput(String)
  }
  
  func parsingInterger(numString: String) throws -> Int {
    guard let num = Int(numString) else {
      throw IntParsingError.invaildInput(numString)	// Error를 반환
    }
    guard let num <= Int64.max, num >= Int64.min else {
      throw IntParsingError.overflow
    }
    return num	// error가 없다면 값 반환
  }
  ```

- Catch custom error

  ```swift
  do {
    let price = try parsingInterger(numString: "$100")
    print(price)	// 성공하면 Int 
  } catch IntParsingError.invalidInput(let invalid) {
    print("Invalid String: '\(invalid)'")
  } catch IntParsingError.oveflow { 
    print("Overflow error")
  } catch {
    print("Unexpected error")
  }
  ```

- 더 세부적인 정보를 표현하기 위해 `struct`에 `Error` protocol을 채택하여 다른 속성을 함께 사용할 수도 있다

  ```swift
  // Define Custom Error
  struct XMLParsingError: Error {
    enum ErrorKind { 
      case invalidCharacter
      case mismatchedTag
    }
    
    let line: Int
    let column: Int
    let kind: ErrorKind
  }
  func parse(_ source: String) thorws -> XMLDoc { 
    // ...
    throw XMLPasringError(line: 19, column: 5, kind: .mismatchedTag)
  }
  
  // Catch Error
  do {
    let source = try parse("source")
  } catch where error is XMLParsingError {		// Error 종류에 따라 처리
    
  } catch where error is IntParsingError {
    
  }
  ```

### LocalizedError

- `errorDescription`, `failureReason`, `recoverySuggestion` 등 문장 형태의 오류 정보를 제공해 주는 속성을 구현하여 사용하도록 하는 protocol

  ```swift
  extension CustomizedError: LocalizedError {
    var errorDescription: String? {
      switch self {
      case .errorWithoutParam:
        return "Error without parameter"
        // NSLocalizedString을 사용하면 다양한 나라의 언어에 대응할 수 있음
  			// return NSLocalizedString("Error without parameter", comment: "")
      case .errorWithParam(let x):
        return "Error with param \(x)"
      }
    }
    var failureReason: String? {
      return "실패 이유"
    }
    var recoverySuggestion: String? {
      return "오류 해결 방법 제안"
    }
  }
  ```

### CustomNSError

- `NSError`를 직접 `throw`하지 않아도, Swift의 error에서도 `domain`, `code`, `userInfo` 등의 속성을 사용할 수 있도록 하는 protocol

  ```swift
  extension CustomizedError: CustomNSError {
    static var errorDomain: String { return "오류 발생 영역이나 범주 등" }
    var errorCode: Int { return -10 }
    var errorUserInfo: [String : Any] { return ["커스텀": "데이터 정의"] }
  }
  ```

## Result

- Swift 5.0부터 추가된 success와 failure 값을 모두 표현할 수 있는 `enum`

  ```swift
  enum Result<Success, Failure> where Failure : Error { 
    case success(Success)
    case failure(Failure)
  }
  ```

- `Success` type에 성공했을 때 결과 값의 타입을, `Failure` type에 `Error` protocol을 채택하고 있는 custom error type을 전달하여 결과 값을 받음

- `Result` 타입의 `.success` 또는 `.failure` case를 받고, 그 **연관값(associated value)**으로 성공한 데이터 또는 실패했을 때 error case를 전달할 수 있다.

  ```swift
  enum NetworkError: Error {
    case badUrl
    case missingData
  }
  
  func downloadImage(
    from urlString: String, 
    completionHandler: (Result<String, NetworkError>) -> Void
  )  {
    guard let url = URL(string: urlString) else {
      return completionHandler(.failure(.badUrl))
    }
    
    // 다운로드를 시도했다고 가정
    print("Download image from \(url)")
    let downloadedImage = "Dog"
  //  let downloadedImage = "Missing Data"
    
    if downloadedImage == "Missing Data" {
      return completionHandler(.failure(.missingData))
    } else {
      return completionHandler(.success(downloadedImage))
    }
  }
  ```

- `downloadImage` 함수 사용 시 `completionHandler`로 전달되는 `Result` 타입의 값을 받아서 error handling

  ```swift
  let url = "https://loremflickr.com/320/240/dog"
  //let url = "No Image Url"
  downloadImage(from: url) { result in
    switch result {
    case .success(let data):
      print("\(data) image download complete")
    case .failure(let error):
      print(error.localizedDescription)
      
      // 에러를 구분해야 할 경우
  //  case .failure(.badUrl): print("Bad URL")
  //  case .failure(.missingData): print("Missing Data")
    }
  }
  ```

- `Result` 타입의 값에서 `get()` 함수를 통해 성공한 값 또는 실패했을 때 error case를 받을 수 있다.

- `get()`은 `thorws` method이므로 `try`를 사용해야 하고, `catch`를 사용하지 않을 경우 `try?`를 사용해서 optional로 변환할 수 있다.

  ```swift
  // get()을 통해 성공한 경우에만 데이터를 가져옴. 아니면 nil 반환
  downloadImage(from: url) { result in
    if let data = try? result.get() {
      print("\(data) image download complete")
    }
  }
  ```

- `Result` 타입에서 직접 `throws` method를 실행시키면 `get()`을 통해 `success`와 `failure` 값을 가져올 수 있다

  ```swift
  let result = Result { try String(contentsOfFile: "ABC") }
  print(try? result.get())
  ```

## Print Log Message

### Print Log

- `print()` : Debug log에 값 및 object 정보 표시

  ```swift
  print("Hello World")	// Hello World
  print(1...10)					// 1...10
  print(dog)						// Dog(name: "Tory", age: 2)
  print(cat)						// Cat(name: "Lilly", age: 3)
  print(self)						// <MyProject.ViewController: 0x7fdce1f16f60>
  ```

- `debugPrint()` : `print`보다 타입 또는 namespace에 대한 정보를 추가적으로 표시

  ```swift
  debugPrint("Hello World")	// "Hello World"
  debugPrint(1...10)				// ClosedRange(1...10)
  debugPrint(dog)						// MyProject.Dog(name: "Tory", age: 2)
  debugPrint(cat)						// MyProject.Cat(name: "Lilly", age: 3)
  debugPrint(self)					// <MyProject.ViewController: 0x7fdce1f16f60>
  ```

- `dump()` : `debugPrint`보다 더 자세한 정보 표시

  ```swift
  dump(1...10)
  /*
  ClosedRange(1...10)
   - lowerBound: 1
   - upperBound: 10
  */
  dump(cat)
  /*
  CustomLogExample.Cat
   - name: "Lilly"
   - age: 2
    ▿ feature: 2 key/value pairs
      ▿ (2 elements)
        - key: "breed"
        - value: "Koshort"
      ▿ (2 elements)
        - key: "tail"
        - value: "short"
  */
  ```

- `NSLog()` : `print`를 사용한 결과에서 log에 print된 시간 정보를 표시

  - `%@` : 문자열, object 등을 문자열 사이에 추가할 때 사용됨
  - `%d` : `Int` 값을 문자열 사이에 추가할 때 사용됨
  - Object를 logging하려고 할 때는 `NSObject`를 상속받도록 해야 함.

  ```swift
  NSLog("Value : %d", 1)
  NSLog("String : %@", "String Value")
  NSLog("Object : $@", cat)
  NSLog("Object : $@", dog.description)	// CustomStringConvertible 채택 시
  ```

### Description

- `CustomStringConvertible` : Object를 `print`로 log에 출력할 때 나타낼 내용을 정의하는 `description` 속성을 구현하게 하는 protocol

- `CustomDebugStringConvertible` : Object를 `debugPrint` 또는 `dump`로 log에 출력할 때 나타낼 내용을 정의하는 `debugDescription` 속성을 구현하게 하는 protocol

  ```swift
  struct Dog: CustomStringConvertible {
    var description: String { 
      return "Dog's name : \(name), age : \(age)"
    }
  }
  
  struct Cat: CustomDebugStringConvertible {
    var debugDescription: String {
      return "Dog's name : \(name), age : \(age), feature: \(feature)"
    }
  }
  ```

- `UIViewController`에는 `NSObject`에 의해 `description`과 `debugDescription` 속성이 이미 정의되어 있으므로 `UIViewController`를 상속받는 subclass에서 해당 속성을 `override`해서 object가 log에 출력될 때 메시지를 설정할 수 있다.

- 어떤 object에서 debugging할 때 **중요한 몇 가지 속성들을 선택적으로 확인**하려고 할 때 활용할 수 있다.

### Special Literals

- 호출된 곳의 파일 이름, 함수 이름, 줄 위치 등 메타 정보를 출력함

  ```swift
  print(#file)			// File Name(Path)(String)
  print(#function)	// Current Function Name(String)
  print(#line)			// Line number(Int)
  print(#column)		// Column number
  ```

- 이 정보를 이용해서 필요한 정보를 갖는 custom logger를 작성할 수 있다

  ```swift
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
  ```

  