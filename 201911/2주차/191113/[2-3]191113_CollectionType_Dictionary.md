

# Collection Type

## Dictionary

- key-value로 표현. key는 유일해야함, value는 중복가능
- Unordered Collection. 순서 없이 key값에 대한 hashvalue로 순서 결정

### Type

- key,  value로 저장
- 같은 key 또는 value 끼리의 타입은 같아야하지만 key와 value의 타입은 다를 수 있음

```swift
let words1: Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
let words2: [String: String] = ["A": "Apple", "B": "Banana", "C": "City"]
let words3 = ["A": "Apple", "B": "Banana", "C": "City"]
```

### Dictionary Usage

- `dictionary[key]`로 key를 이용해 value에 접근. 해당 key가 없을 수 있으므로 optional type으로 value를 반환

  ```swift
  let words1: Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
  words["A"]	// Optional("Apple")
  words["Q"]	// nil
  ```

- `dictionary[key] = value`로 `key-value` pair를 추가. 기존에 `key`가 있었다면 값을 변경

- `updateValue(_:forKey:)`를 이용하면 기존에 dictionary에 있던 `key`에 대해 새로운 `value`로 update. `key`가 dictionary에 없다면 `nil` 반환

  ```swift
  let words1: Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
  words["C"] = "Car"	// City를 Car로 변경
  words["D"] = "Dog"	// "D":"Dog"의 key-value pair를 추가
  words.updateValue("D", forKey: "Dragon")	// Dog를 Dragon으로 변경
  words.updateValue("E", forKey: "Eraser")	// words에 "E"라는 key가 없으므로 nil 반환
  ```

- `dictionary[key] = nil`로 key에 해당하는 `key-value` pair를 삭제. 

- `dictionary.removeValue(forKey: key)`로 특정 key를 지우고 해당 key의 value를 반환

- `removeAll()`로 모든 `key-value` pair를 삭제

  ```swift
  let words1: Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
  words["C"] = "Car"	// City를 Car로 변경
  words["D"] = "Dog"	// "D":"Dog"의 key-value pair를 추가
  words.updateValue("D", forKey: "Dragon")	// Dog를 Dragon으로 변경
  words.updateValue("E", forKey: "Eraser")	// words에 "E"라는 key가 없으므로 nil 반환
  ```

### Check Items

- `count` : Dictionary의 `key-value` pair의 개수 반환

- `isEmpty` : Dictionary가 비었는지 확인

- `keys` : Dictionary의 모든 `key-value` pair에서 key들을 `Dictionary<>.keys` 타입으로 반환. `Array(dictionary.keys)`로 key들을 배열로 받아올 수 있음

- `values` : Dictionary의 모든 `key-value` pair에서 value들을 `Dictionary<>.values` 타입으로 반환. `Array(dictionary.values)`로 value들을 배열로 받아올 수 있음

- `contains(where:)` : closure를 넣어서 `(key, value)` pair에 대해 `key`와 `value`에 대해 각각 포함하고 있는지 확인할 수 있음

  ```swift
  if words.contains(where: { (key, value) -> Bool in
    return key == "A"}) {
    print("contains A key.")
  }
  ```

### Enumerating

- `for in`에서 dictionary를 순회할 때 `(key: String, value: String)` tuple로 순회

- `dictionary.keys` 또는 `dictionary.values`로 순회하면 dictionary의 key 또는 value들에 대해서만 각각 순회

- key와 value를 선택적으로 받아서 사용

  ```swift
  for kvp in dictionary { ... }
  for (key, value) in dictionary { ... }
  for (_, value) in dictionary { ... }
  for (key, _) in dictionary { ... }
  for key in dictionary.keys { ... }
  for value in dictionary.values { ... }
  ```

### Nested Dictionary

- Array도 사용 가능하지만 dictionary에서 중첩하는 경우가 많다
- `value`에서 array 또는 dictionary를 중첩해서 사용할 수 있음. key는 반드시 단읾값
- JSON format data를 사용할 때

```swift
// key가 string이고 value가 배열인 dictionary
var dict1 = [String: [String]]()
dict1["arr1"] = ["A", "B", "C"]
dict1["arr2"] = ["D", "E", "F"]

// key가 string이고 value가 dictionary인 dictionary
var dict2 = [String: [String: String]]()
dict2["user"] = [
  "name": "나개발",
  "job": "iOS 개발자",
  "hobby": "코딩",
]
```

- Dictionary나 array에서 마지막 item 뒤에 콤마(`,`)를 붙이는건 자유. 이후 git을 사용할 때 변경되는 줄을 줄이려면 항상 마지막 item 뒤에 콤마를 붙이는게 좋다

  ```swift
  [
    "apps": [
      "이런 앱",
      "저런 앱",
      "잘된 앱",
      "망한 앱",			// 여기에 콤마를 붙였으면
      "망한 앱1",		// 한줄 추가할 때 git에서 변경사항이 한줄.
    ]
  ]
  
  [
    "apps": [
      "이런 앱",
      "저런 앱",
      "잘된 앱",
      "망한 앱",			// 여기에 콤마를 붙이지 않았으면
      "망한 앱1",		// 새로운 데이터를 추가할 떄 git에서 변경사항이 두줄이 됨
    ]
  ] 
  ```

  