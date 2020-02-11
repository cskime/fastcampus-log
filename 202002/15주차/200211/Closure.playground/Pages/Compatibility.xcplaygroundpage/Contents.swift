//: [Previous](@previous)
import Foundation
/*:
 # Compatibility
 */
/*
 (O) @noescaping -> @noescaping
 (O) @escaping   -> @noescaping, @escaping
 (X) @noescaping -> @escaping
 */

class Test {
  var storedProperty: (() -> ())?
  
  func someFunction(_ param: ()->()) {
    noEscapingClosure(param)    // (O) NoEscaping -> NoEscaping
//    param() // 위와 같음
    
//    self.storedProperty = param    // (X) required @escaping
//    escapingClosure(param)   // (X) NoEscaping -> Escaping
  }
  
  func noEscapingClosure(_ param: () -> ()) {
    param()
//    self.storedProperty = param   // (X)
    // noEscapingClosure 함수가 종료되어도 param closure는 storedProeprty에 저장되어 계속 남아있으므로 @escaping 키워드가 필요하다
  }
  
  func escapingClosure(_ param: @escaping () -> ()) {
    self.storedProperty = param
  }
}



//: [Next](@next)
