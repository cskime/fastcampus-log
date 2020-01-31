//: [Previous](@previous)
import Foundation
/*:
 ---
 # LocalizedError, CustomNSError
 ---
 */

enum MyError: Error {
  case errorWithoutParam
  case errorWithParam(num: Int)
}

// 발생한 오류가 정확히 무엇인지 알기 어려움
func throwsErrorExample() {
  do {
    throw MyError.errorWithoutParam
  } catch {
    print(error.localizedDescription)
  }
}
throwsErrorExample()




print("\n---------- [ LocalizedError ] ----------\n")

enum CustomizedError: Error {
  case errorWithoutParam
  case errorWithParam(num: Int)
}

func localizedErrorExample() {
  do {
    throw CustomizedError.errorWithoutParam
  } catch {
    print(error.localizedDescription)
    
    let e = error as NSError
    print(e.localizedFailureReason ?? "")
    print(e.localizedRecoverySuggestion ?? "")
  }
}
localizedErrorExample()


// LocalizedError 프로토콜
// > errorDescription, failureReason, recoverySuggestion 등 오류에 대한 정보 제공 (문장 형태)

extension CustomizedError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .errorWithoutParam:
       return "Error without parameter"
//       return NSLocalizedString("Error without parameter", comment: "")
    case .errorWithParam(let x):
      return "Error with param \(x)"
    }
  }

  public var failureReason: String? {
    return "실패 이유"
  }
  public var recoverySuggestion: String? {
    return "오류 해결 방법 제안"
  }
}




print("\n---------- [ CustomNSError ] ----------\n")

extension CustomizedError: CustomNSError {
  static var errorDomain: String { return "오류 발생 영역이나 범주 등" }
  var errorCode: Int { return -10 }
  var errorUserInfo: [String : Any] { return ["커스텀": "데이터 정의"] }
}

func customNSErrorExample() {
  do {
    throw CustomizedError.errorWithoutParam
  } catch {
    let e = error as NSError
    print(e.domain)
    print(e.code)
    print(e.userInfo)
  }
}
customNSErrorExample()


// CustomNSError 프로토콜
// > errorDomain, errorCode, errorUserInfo 정의





//: [Next](@next)
