//: [Previous](@previous)
import Foundation
/*:
 ---
 # Escaping
 - 함수나 메서드의 파라미터 중 클로져 타입에 @escaping 키워드 적용
 - 해당 파라미터가 함수 종료(return) 이후 시점에도 어딘가에 남아 실행될 수 있음을 나타냄
   - outlives the lifetime of the function
 - 해당 파라미터가 함수 외부에 저장(stored)되거나 async(비동기)로 동작할 때 사용
 - self 키워드 명시 필요
 ---
 */

class Callee {
  deinit { print("Callee has deinitialized") }
  
  func noEscapingFunc(closure: () -> Void) {
    closure()
  }
  func escapingFunc(closure: @escaping () -> Void) { closure() }
}


class Caller {
  deinit { print("Caller has deinitialized") }
  let callee = Callee()
  var name = "James"
  
  func selfKeyword() {
    // self keyword (X)
    callee.noEscapingFunc { name = "Giftbot" }
    
    // self keyword  (O)
    callee.escapingFunc { self.name = "Giftbot" }
  }
  
  
  
  func asyncTask() {
    callee.noEscapingFunc {
      DispatchQueue.main.async {
        self.name = "Giftbot" // noEscapingFunc에서 사용되었지만, DispatchQueue.main.async라는 다른 곳에서 클래스 파라미터를 사용하므로 self 참조가 외부로 전달되기 때문에 self를 명시해서 capture해야 한다.
      }
    }
    callee.escapingFunc {
      DispatchQueue.main.async {
        self.name = "Giftbot"
      }
    }
  }
  
  
  func captureAsStrong() {
    callee.escapingFunc {
      print("-- delay 2seconds --")
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.name = "Giftbot"
        // self 사용으로 caller의 참조가 잡혀있다. 2초 뒤에 비동기 closure가 실행되고 종료되어야 완전히 해제됨.
      }
    }
  }
  
  func weakBinding() {
    callee.escapingFunc { [weak self] in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("-- after 2seconds with weak self --")
        self?.name = "Giftbot"
        print(self?.name ?? "nil")
        // self를 capture list에 잡아서 weak 키워드를 적용하면 closure 내에서 self관련 변수가 사용될 떄 참조를 잡지 않으므로 해제되어야 할 떄 memory rick 발생하지 않는다
      }
    }

    // 주변 문맥을 캡쳐 -> scope를 따름
    // DispatchQueue 안에서 self 사용
    // DispatcyQueue 주변의 self -> escapingFunc 안에 self 사용
    // escapingFunc 안에 self 없으면 그 외부 -> class 자체의 self 사용
    callee.escapingFunc { [weak self] in
      guard let `self` = self else { return print("Caller no exist") }
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("-- after 2seconds with weak self --")
        self.name = "Giftbot"
      }
    }
    
    // 적어도 이 안에 있는 코드들은 다 실행하고 끝내라는 의미로
    // self를 별도의 변수로 다시 받아와서 사용
    // 2초 뒤에 deinit됨
  }
  
  func unownedBinding() {
    callee.escapingFunc { [unowned self] in
      let `self` = self
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("-- after 2seconds with unowned self --")
        print("Oops!!")
        
        self.name = "Giftbot"   // crash. self가 죽더라도 포인터 주소를 유지하고 있기 때문에 없는 곳에 접근하려고 해서 crash가 발생함.
        print(self.name)
      }
    }
  }
}


var caller: Caller? = Caller()
//caller?.selfKeyword()
//caller?.asyncTask()
//caller?.captureAsStrong()
//caller?.weakBinding()
caller?.unownedBinding()

print("caller = nil")
caller = nil




//: [Next](@next)
