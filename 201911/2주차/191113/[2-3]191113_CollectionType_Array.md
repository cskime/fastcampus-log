# Collection Type

- Swift
  - Array : ordered collections for values
  - Dictionary : unordered collections of key-value associations
  - Set : unordered collections of unique values
- Objective-C(Foundation framework)
  - NSArray, NSMutableArray
  - NSDictionary, NSMutableDictionary
  - NSSet, NSMutableSet

## Array

- Ordered collection
- Zero-based integer index
- `var` : mutable, `let` : immutable

### Type

```swift
// Literal type. value의 type으로 array의 type 추론
let arr1 = [1, 2, 3]
let emptyArray = []			// 타입을 추론할 literal value가 없으므로 오류

// Type Annotation
let arr2: [Int] = [1, 2, 3]
let arr3: Array<Int> = [1, 2, 3]

// Type Inference
let arr4 = [Int]()	// empty Int array
let arr3 = Array<Int>(repeating: 1, count: 3)		// [1, 1, 1]
```

### Usage

- `array[index]`로 배열의 원소에 접근하거나 값 변경 가능. Array의 index를 벗어나서 접근하면 오류

  ```swift
  let arr = [1, 2, 3]
  arr[2]			// 3
  arr[1] = 3	// [3, 2, 3]	
  arr[3]			// index를 벗어나서 오류
  ```

- `append(_:)` : value를 배열 뒤에 이어붙임

  ```swift
  let arr = [Int]()
  arr.append(1)
  arr += [2]	// literal을 연산자를 통해 추가
  // [1, 2]
  ```

- `insert(_:,at:)` : value를 `at`에 해당하는 index에 넣음. `at`부터 뒤에 있는 item들을 뒤로 밀고 그 자리에 새로운 값을 삽입

  ```swift
  let arr = [1, 2, 3]
  arr.insert(4, at: 2)
  // 1, 2, 4, 3
  ```

- `array[a...b]`처럼 범위 연산자로 배열에서 여러 개의 값을 뽑아서 또 다른 배열 생성

  ```swift
  let arr = [1, 2, 3, 4, 5]
  arr[2...]		// [3, 4, 5]
  arr[...2]		// [1, 2]
  arr[2...] = [5, 6]
  arr		// index 2 이상 값을 지우고 새로운 값으로 대체: [1, 2, 5, 6]
  ```

- `remove()` : 배열에 item을 삭제

  ```swift
  let arr = [1, 2, 3, 4, 5]
  arr.remove(at:3) 	// index 3에 있는 값을 삭제하고 삭제한 값을 반환
  // arr: [1, 2, 3, 5]
  arr.removeAll()		// 모든 item을 삭제. 빈 배열이 됨
  // arr: []
  arr.removeFirst()	// 가장 앞 item을 삭제하고 그 값을 반환
  // arr: [2, 3, 4, 5]
  arr.removeLast()	// 가장 뒤 item을 삭제하고 그 값을 반환
  // arr: [1, 2, 3, 4]
  ```

### Sort

- `shuffle()` : 현재 array를 직접 섞음

- `shuffled()` : 현재 array를 섞은 결과를 반환. 현재 array는 변하지 않음

  ```swift
  let arr = [1, 2, 3, 4, 5]
  arr.shuffle()	
  // arr: [3, 2, 5, 1, 4]
  let arr2 = arr.shuffled()	
  // arr: [1, 2, 3, 4, 5], arr2: [3, 2, 5, 1, 4]
  ```

- `sort()` : 현재 array를 직접 정렬

- `sorted()` : 현재 array를 정렬한 결과를 반환

  ```swift
  let arr = [5, 4, 3, 2, 1]
  arr.sort()
  // arr: [1, 2, 3, 4, 5]
  let arr2 = arr.sorted()
  // arr: [5, 4, 3, 2, 1], arr2: [1, 2, 3, 4, 5]
  
  // sorted(by:)로 closure를 넣어서 내림차순,오름차순 정렬 구분
  let arr3 = arr.sorted(by: >)	// 내림차순. 오름차순은 (<)
  // arr3: [5, 4, 3, 2, 1]
  ```

### Check Items

- `count` : 배열 item의 개수

- `isEmpty` : 배열이 비었는지 확인

- `startIndex` : 시작 index. 일반적으로 0

- `endIndex` : 배열의 마지막 원소 다음 index를 가리킴. 배열의 count와 같음

  ```swift
  let arr = [1, 2, 3]
  arr[arr.firstIndex] 	// 1
  arr[arr.endIndex - 1]	// 3
  ```

- `contains(_:)` : 배열에 해당 value가 존재하는지 확인

  - `contains(where:)` : `where`에 `Bool`을 반환하는 closure 사용

- `firstIndex(of:)` : 배열에서 해당 value가 처음 등장하는 index를 optional type으로 반환

- `lastIndex(of:)` : 배열에서 해당 value가 마지막에 등장하는 index를 optional type으로 반환

- `max()`/`min()` : 배열의 가장 큰/작은 값을 반환. optional type 반환. Int로만 값을 반환하므로 다른 타입 array일 경우를 고려해서 optional type 반환

### Enumerating

- `for in` loop으로 array의 item 순회할 때 `enumerated()` method를 이용하면 배열의 item과 index를 모두 사용하면서 순회할 수 있음

  ```swift
  let arr = [1, 2, 3]
  for item in arr {
    print(item)		// 1, 2, 3
  }
  
  for (index, item) in arr.enumerated() {
    print("arr value at \(index) is \(item)")
  }
  
  // enumerated()는 (offset: Int, element: ItemType)의 tuple을 가짐
  for tuple in arr.enumerated() {
    print("arr value at \(tuple.0) is \(tuple.1)")
  	print("arr value at \(tuple.offset) is \(tuple.element)")
  }
  ```