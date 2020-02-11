//: [Previous](@previous)
import Foundation
/*:
 ---
 # NoEscaping
 - 기본값 (Swift 3.0 버전 이전까지는 @escaping이 기본)
 - 함수에서 사용된 파라미터는 함수 종료와 함께 소멸
 - self 키워드 불필요
 ---
 */
class Callee {
  deinit { print("Callee has deinitialized") }
  
  func doSomething(closure: () -> Void) { closure() }
}

class Caller {
  deinit { print("Caller has deinitialized") }
  
  let callee = Callee()
  var name = "James"
  
  func doSomething() {
    callee.doSomething {
      self.name = "Giftbot"
      name = "Giftbot"      // no escaping 환경에서 self 필요없음. 즉, 함수가 종료될 때 capture한 값들이 바로 메모리에서 해제됨.
      // callee.doSomething method에 전달되는 클로저는 no-escaping. 해당 closure 실행이 종료될 떄 caller에 있는 name이 함수 외부로 반환되거나 탈출하지 않으므로 self 불필요
    }
  }
}


print("---------- [ NoEscaping ] ----------\n")

var caller: Caller? = Caller()
caller?.doSomething()

print("caller = nil")
caller = nil



//: [Next](@next)
