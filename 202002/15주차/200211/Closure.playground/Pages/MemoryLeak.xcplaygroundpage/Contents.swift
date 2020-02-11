//: [Previous](@previous)
import Foundation
//: # MemoryLeak

// Dog has bark : closure. reference type.
// bark property has Dog instance
// Dog class와 bark closure가 서로 강한 순환참조 관계
// self를 unowned, weak 등을 통해 클로저에서 capture될 때 rc 조절


print("\n---------- [ Lazy var closure ] ----------\n")

final class Dog {
  let name: String = "토리"
  
  lazy var bark: () -> () = { [weak self] in
    guard let self = self else { return }
    print(self.name + "가 짖습니다.", terminator: " ")
  }
  deinit { print("이 문장 보이면 아님 ->", terminator: " ") }
}

var dog: Dog? = Dog()
dog?.bark()
dog = nil
print("메모리 릭!\n")



print("\n---------- [ weak capture ] ----------\n")

final class Callee {
  deinit { print("🔫🔫 응. 아니야.") }
  var storedProperty: (() -> ())?
  
  func noEscapingFunc(closure: () -> Void) {
//    self.storedProperty = closure    // Compile Error
  }
  func escapingFunc(closure: @escaping () -> Void) {
    self.storedProperty = closure
  }
  
  
  // closure를 반환시킬 때도 함수 실행이 종료된 뒤 다른 곳으로 반환되어 저장될 가능성이 있으므로 escaping
//  func escapingFunc(closure: @escaping () -> Void) -> ()->() {
//    return closure
//  }
}


final class Caller {
  let callee = Callee()
  var name = "James"
  
  func memoryLeak() {
    // 1)
//    callee.escapingFunc {
//      self.name = "Giftbot" // 상호 강한참조 관계가 발생하면서 memory leak : Caller <-> Callee
//    }
    
    // 2)
    callee.escapingFunc { [weak self] in
      self?.name = "Giftbot"
    }
  }
  
  func anotherLeak() {
    // 1)
//    callee.escapingFunc {
//      DispatchQueue.main.async { }
//    }
    
    // 2)
    callee.escapingFunc {
      DispatchQueue.main.async { [weak self] in
        self?.name = "Giftbot"
      }
    }
    // Capture List가 escapingFunc가 아닌 Dispatch에서 선언됨.
    // weak self를 썼지만 실제로 self가 사용되는 것은 DispatchQueue closure 안이다. 이것은 callee 안에 들어간 self가 담기는 것. class의 self가 담긴게 아니다.

    // 3)
//    callee.escapingFunc { [weak self] in
//      DispatchQueue.main.async {
//        self?.name = "Giftbot"
//      }
//    }
  }
}

print("버그??? 🐛🐛🐛", terminator: "  ")

var caller: Caller? = Caller()
caller?.memoryLeak()
//caller?.anotherLeak()


DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
  caller = nil
}



//: [Next](@next)
