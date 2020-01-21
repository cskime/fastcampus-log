# 고차 함수(High Order Function)

- 하나 이상의 함수를 인자로 취하는 함수
- 함수를 결과로 반환하는 함수
- 일급 객체(First-class Citizen)만이 고차함수가 될 수 있다. 
- **즉, 일급 객체가 될 수 있는 함수가 고차 함수가 될 수 있다.**
- 주로 Collection Type에 사용됨

## 일급 객체(First-Class Citizen)

- 변수나 데이터에 할당할 수 있다
- 객체의 인자로 넘길 수 있다
- 객체의 반환값이 될 수 있다

## Swift의 High-Order Function

- `forEach` : Collection의 각 element에 동일한 연산을 적용. 반환값이 없다.

  - `Element` : 어떤 값이든 들어올 수 있음. Collection element가 `Int` 타입이면 `Element`에도 `Int` 타입 값이 들어옴
  - `for`문과 차이점 : `for`는 `break`을 통해 loop 중간에 빠져나올 수 있지만, `forEach`는 `return`시켜도 **중간에 멈추지 않고 element 개수만큼 함수를 반복 실행**

  ```swift
  let immutableArray = [1, 2, 3, 4]
  immutableArray.forEach { (element) in 
  	print(element, terminator: " ")
  }
  // 1, 2, 3, 4
  ```

- `map` : Collection의 각 element에 동일한 연산을 적용하여 변형된 새로운 collection으로 반환

  - `for`문과 비교 : `for`문에서는 collection 변수를 미리 정의해 두고 `for`문을 통해 얻은 element를 추가해 주는 방식이지만, `map`은 미리 변수를 지정해 두지 않아도 됨

  ```swift
  let names = ["Chris", "Alex", "Bob", "Barry"]
  names.map { $0 + "'s name" }.forEach { print($0) }
  // Chris's name
  // Alex's name
  // ...
  ```

- `filter` : Collection의 각 element를 평가하여 조건을 만족(`true` 반환)하는 element만 남겨서 새로운 collection으로 반환

  ```swift
  let names = ["Chris", "Alex", "Bob", "Barry"]
  let containBNames = names.filter { (name) -> Bool in
  	return name.contains("B")
  }
  print(containBNames)
  // ["Bob", "Barry"]
  ```

- `reduce` : Collection의 각 element를 결합하여 하나의 값으로 반환

  - 초기값(`initialResult`)을 정하고, 각 `element`에 대한 연산을 통해 `result`로서 값을 반환.
  - 매 함수 실행마다 반환되는 값이 새로운 `result`값으로 갱신됨. **`result`에 직접 연산하는 것이 아님**

  ```swift
  let mergedString1 = ["1", "2", "3"].reduce("", +)
  print(mergedString1)	// "123"
  
  let mergedString2 = [1, 2, 3].reduce("") { $0 + String($1) }
  print(mergedString2)	// "123"
  ```

- `compactMap` : Collection에서 `optional` 타입의 element에 대해 `nil`인 요소를 제거한 뒤 **unwrapping된 collection**으로 반환

  ```swift
  let optionalStringArr = ["A", nil, "B", nil, "C"]
  print(optionalStringArr)	
  // [Optional("A"), nil, Optional("B"), nil, Optional("C")]
  print(optionalStringArr.compactMap { $0 })
  // ["A", "B", "C"]
  ```

- `flatMap` : 중첩된 collection(이중배열, 삼중배열 등)을 하나의 collection으로 반환.

  -  `flatMap` 한 번 수행하면 한 단계가 풀림. 삼중 배열에서 모든 중첩 collection을 풀기 위해 `flatMap`을 두 번 사용해야함

  ```swift
  let nestedArr: [[Int]] = [[1, 2, 3], [9, 8, 7], [-1, 0, 1]]
  let unNestedArr = nestedArr.flatMap { $0 }
  // [1, 2, 3, 9, 8, 7, -1, 0, 1]
  
  let nestedArr2: [[[Int]]] = [[[1, 2], [3, 4], [5, 6]], [[7, 8], [9, 10]]]
  nestedArr2
    .flatMap { $0 }
    .flatMap { $0 }
  ```

### 순수함수

- 입력 값이 들어왔을 때 그에 따른 반환 값이 일정한 함수?
- 함수형 프로그래밍 패러다임, 어떤 입력 값을 넣었을 때 반드시 특정 값을 반환하는 함수를 기반으로 프로그래밍