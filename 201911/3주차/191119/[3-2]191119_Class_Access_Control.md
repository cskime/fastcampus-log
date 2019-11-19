# Access Control

- 다른 모듈의 코드 또는 소스 파일 등으로부터 접근을 제한하는 것
  - 모듈(module) : `import`를 통해 다른 모듈로부터 불러들일 수 있는 하나의 배포 단위(Library / Framework / Application)
  - 소스파일(source file) : 모듈 내에 포함된 각각의 Swift 소스 파일
- 세부 구현 내용을 숨기고(은닉화) 접근할 수 있는 인터페이스 지정 가능

## Access Levels

- `open` : 다른 외부 모듈에서 접근 가능함 + `override` 또는 `subclass`를 통해 내용 수정까지도 가능
- `public` : `import`를 통해 다른 모듈에서 접근 가능하도록 함(Framework  단계)
- `internal` : 모듈 안에서 접근 가능(기본값)
- `fileprivate` : 지금 다루는 파일에서만 접근 가능(`.swift`)
- `private` : 클래스 내에서만 사용할 수 있도록 제한(`{}` 안에서만 사용)
- 기본 `internal` 레벨. `open`이 가장 개방적, `private`이 가장 제한적

## Access on Class

- Class의 access level은 모든 property 및 method에 영향을 줌. 즉, class의 access level은 class 자체에 접근하는 수준을 설정하고, property 또는 method의 access level은 일단 class에 접근해서 객체를 만들고 난 후, 객체가 접근할 수 있는 수준을 설정하는 것임.

- `class`의 최고 level은 `open`. `struct`의 최고 access level은 `public`. `override` 및 상속이 불가능하기 때문

- Class의 property 또는 method에 class의 access level보다 높은 level을 설정한다 해도 class 자체에 접근할 수 있어야하므로 의미가 없다

  ```swift
  private PrivateClass {
    public var publicProperty = 0	
    // Private class는 어차피 접근할 수 없으므로 public property가 의미가 없다
  }
  // let privateClass = PrivateClass()
  ```

- Class의 access level이 `private`일 때는 class를 사용하는 의미가 없으므로, `fileprivate`을 붙인 것 처럼 동작하게 됨. 즉, 같은 파일 안에서만 접근 가능해진다.

  ```swift
  // SameFile.swift
  private PrivateClass {	}
  fileprivate FilePrivateClass {	}
  
  class SomeClass {
  	var privateClass = PrivateClass()
    var filePrivateClass = FilePrivateClass()
  }
  ```

- Class의 access level에 따라 class의 property 및 method의 access level의 기본값이 정해짐

|            Class             | Property & Method |
| :--------------------------: | :---------------: |
| `open`, `public`, `internal` |    `internal`     |
|   `private`, `fileprivate`   |     `private`     |

- 일반적으로 하나의 file에 하나의 class를 담기 때문에 `fileprivate`을 사용하는 경우는 드물다.

## Getter & Setter

- Getter : 값을 읽어들이는 것. property에 접근해서 값을 가져오는 것.

- Setter : 값을 입력하는 것. Property에 값을 저장하는 것

- 보통 getter/setter는 그것이 속하는 변수 및 상수의 접근 레벨과 동일한 레벨을 갖지만, 별도로 설정할 수 있음

  - 지금까지 property에 설정한 access level은 getter와 setter의 access level을 모두 설정해 준 것

  - Setter 하나에만 접근을 제한하고 싶은 경우 `private(set)` 같이 직접 명시

  - Getter 하나에만 접근을 제한할 수는 없고, getter와 setter의 access level을 모두 설정해서 지정할 수 있음

    ```swift
    // {getter access level} {setter access level}(set) var property: Type = value
    private internal(set) var value = 0
    ```

- 저장 프로퍼티의 값을 직접 수정할 수 없도록 제한하는 경우

  ```swift
  class TrackedString {
  //  var numberOfEdits = 0
  //  private var numberOfEdits = 0				// numberOfEdits를 수정할 수 없지만 접근조차 할 수 없음
  	
    // numberOfEdits에 접근할 수 있지만 직접 수정할 수 없음. 클래스 내부에서만 수정 가능
    private(set) var numberOfEdits = 0		
  
    var value: String = "" {
      didSet { numberOfEdits += 1 }
    }
  }
  
  let trackedString = TrackedString()
  trackedString.value = "value changed"
  trackedString.numberOfEdits
  // trackedString.numberOfEdits = 0		// numberOfEdits를 직접 수정할 수 없도록 제한하기 위해
  // trackedString.numberOfEdits				// setter에 대해 private level로 접근을 제한
  ```

## Types

### Tuple

- `Tuple`에서 접근 제한된 type을 값으로 가질 때, 가장 낮은 수준의 접근 제한이 걸린 타입과 같은 수준의 접근 제한 설정된 tuple 변수로 받아야함

```swift
internal class SomeInternalClass {}
private class SomePrivateClass {}

fileprivate func returnTupleFunction() -> (SomeInternalClass, SomePrivateClass) {
  return (SomeInternalClass(), SomePrivateClass())
}

// Tuple에서 access level이 더 낮은 SomePrivateClass의 access level로 맞춤
//let result = returnTupleFunction()
fileprivate let result = returnTupleFunction()
```

### Enumeration Types

- 접근 제한 레벨이 설정된 `enum`의 변수를 만들 때, 그 변수도 `enum`의 접근 제한 레벨과 맞게 선언해야함
- `enum`에서 접근 제한은 `case`단위로는 못하고 연산 프로퍼티나  `enum` 자체에 적용 가능.

```swift
private enum 방위1 {
  case 동, 서, 남, 북
}

//let enumeration = 방위1.남
fileprivate let enumeration = 방위1.남
```

### Type Alias

- `typealias`를 이용해서 타입의 이름을 변경하면서 접근 제한 레벨을 설정할 수 있음
- 같은 class를 타입 이름에 따라 다른 접근 제한 레벨로 사용할 수 있음

```swift
class AliasClass {
  let someProperty = 1
}

//public typealias Typealiases = AliasClass
//internal typealias Typealiases = AliasClass
fileprivate typealias Typealiases = AliasClass

// internal 레벨인 AliasClass를 typealias를 이용해 fileprivate 레벨인 Typealias 타입으로 사용
fileprivate let aliasesInstance = Typealiases()		
aliasesInstance.someProperty
```



