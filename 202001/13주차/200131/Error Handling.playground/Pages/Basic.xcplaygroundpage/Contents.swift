//: [Previous](@previous)
import Foundation
/*:
 ---
 # Basic
 ---
 */

let tmpDir = NSTemporaryDirectory()
let filePath = NSTemporaryDirectory() + "swift.txt"
print(tmpDir)


func writeMethodExample() {
  // Error
//  "Swift Error Handling"
//    .write(toFile: filePath, atomically: true, encoding: .utf8)
  
//  try? "Swift Error Handling"
//    .write(toFile: filePath, atomically: true, encoding: .utf8)
  
  /***************************************************
   func write(toFile:atomically:encoding:) throws
   - throws 키워드 주목
   - Error 발생 시 처리하기 위한 코드 필요
   ***************************************************/
}
writeMethodExample()



print("\n---------- [ Three Types of Try ] ----------\n")

func threeTypesOfTry() {
  /***************************************************
   try  -  do ~ catch 없이 단독 사용 불가.
   ***************************************************/
  print("1. try")
  do {
    let fileContents = try String(contentsOfFile: filePath)
    print(fileContents)
    
    let fileContents1 = try String(contentsOfFile: tmpDir)
    print(fileContents1)
  } catch {
    print(error.localizedDescription)
  }
  
  /***************************************************
   try?  -  성공하면 Optional 값 반환, 에러가 발생하면 nil 반환
   ***************************************************/
  print("\n2. try?")
  let contentsOptional = try? String(contentsOfFile: filePath)
  print(contentsOptional ?? "nil")
  
  let contentsError = try? String(contentsOfFile: tmpDir)
  print(contentsError ?? "nil")
  
  /***************************************************
   try!  -  Optional 강제 언래핑. 단, 에러 발생 시 crash.
   ***************************************************/
  print("\n3. try!")
  let contentsUnwrapped = try! String(contentsOfFile: filePath)
  print(contentsUnwrapped)
//  let unwrappedError = try! String(contentsOfFile: tmpDir)
//  print(unwrappedError)
}
threeTypesOfTry()



print("\n---------- [ doTryFlow ] ----------\n")

func doTryFlow() {
  do {
    // 아래 내용 실행 결과?
    let r1 = try String(contentsOfFile: filePath);  print("r1 :", r1)
    let r2 = try? String(contentsOfFile: filePath); print("r2 :", r2 ?? "")
    let r3 = try? String(contentsOfFile: tmpDir);   print("r3 :", r3 ?? "")
    let r4 = try String(contentsOfFile: tmpDir);    print("r4 :", r4)
    let r5 = try! String(contentsOfFile: filePath); print("r5 :", r5)
    let r6 = try! String(contentsOfFile: tmpDir);   print("r6 :", r6)
  } catch {
    print(error.localizedDescription)
  }
}
doTryFlow()



/***************************************************
 do ~ catch 블럭 내에서 에러가 발생하면 해당 코드 이후의 내용들은 실행되지 않음.
 ***************************************************/




print("\n---------- [ Throw Error ] ----------\n")

enum MyError: Error {
  case errorWithoutParam
  case errorWithParam(num: Int)
}

func throwError() throws {
  /***************************************************
   throws 메서드에서는 throw 를 통해 직접 에러를 던지거나
   throws 메서드에 대해 do catch 문 없이 단순히 try 만을 사용할 수도 있다.
   ***************************************************/
  // Code...
  
  // try
  try String(contentsOfFile: tmpDir)
  
  // throw
//  throw MyError.errorWithParam(num: -1)
}

func throwsErrorExample() {
  do {
    try throwError()
  } catch {
    print("Error :", error)
    print("=====")
    print("Error Description :", error.localizedDescription)
  }
}
throwsErrorExample()




print("\n---------- [ Error Matching ] ----------\n")

func errorMatching() {
  do {
    try throwError()
  } catch MyError.errorWithoutParam {
    print("Error without param")
  } catch MyError.errorWithParam(let num) {
    print("Error with number param :", num)
  } catch {
    print("The others")
  }
}
errorMatching()



//: [Next](@next)
