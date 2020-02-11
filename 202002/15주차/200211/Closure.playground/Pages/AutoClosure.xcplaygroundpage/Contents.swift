//: [Previous](@previous)
/*:
 # AutoClosure
 * 입력 파라미터가 없는 표현식을 클로저로 변환하는 키워드
 * 입력 파라미터가 없는 클로저에 사용 e.g. ()->(), ()->Int
*/

/*:
 ---
 #### Normal Closure
 ---
 */
// 일반적인 클로저 사용 방식

func someFunc(_ str: String, _ closure: () -> ()) {
  let _ = str
  closure()
}

someFunc("arg1") { let _ = 1 + 1 }

var value1 = 10
someFunc("arg1") { value1 += 10 }

func myFunction() {}
someFunc("arg1", myFunction)


/*:
 ---
 ## AutoClosure
 - closure 파라미터에 대입할 내용을 일반 함수 파라미터처럼 입력
 ---
 */

func anotherFunction(_ str: String, _ closure: @autoclosure () -> ()) {
  let _ = str
  closure()
}
anotherFunction("arg1", print("Autoclosure"))

var value2 = 10
anotherFunction("arg1", value2 += 10)



// 대신 일반 클로저처럼 사용 불가

// Compile Error
//anotherFunction("arg1") {
//  print("Do Something")
//}

// Compile error
//anotherFunction("arg1", myFunction)


//: [Next](@next)
