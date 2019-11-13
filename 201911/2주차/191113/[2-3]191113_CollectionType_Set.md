

# Collection Type

## Set

- Set Literal = Array Literal. `[ ]`을 `Set` 타입 없이 쓰면 `Array`로 추론됨
- Unordered and Unique collection.
- Array, dictionary에 비해 빈도가 낮은 빈도
- 데이터를 많이 다뤄야 하는 상황 또는 수학적인 것을 다루는 상황에서 사용할 수 있음

### Usage

- `count` : Set의 item 개수 반환
- `isEmpty` : Set이 비었는지 확인
- `first` : 첫 번째 값을 반환. 비어있을 때 없을 수 있으므로 optional type
  - Set은 순서가 없으므로 배열처럼 `set[0]`처럼 index 접근 불가
- `contains(_:)` : Set에 값이 포함되어 있는지 확인
- `insert(_:)` : Literal(`[ ]`)은 순서가 있는지 없는지 모르기 때문에(array인지 set인지 모르기 때문에) `append()`나 `insert()`를 직접 사용할 수 없음
  - Array는 `append()`, Set은 `insert`
  - Set의 `insert(_:)`는 `(inserted: Bool, memberAfterInsert: Type)` 튜플을 반환. 
- `remove(_:)`로 특정 element 제거. `removeAll()`로 전체 삭제

### Compare

- 두 개의 `Set`을 equal compare(`==`)하면 순서에 상관없이 아이템들이 같을 때 `true`

- 순서까지 같아야한다면 `elementsEqual(_:)`으로 비교

  ```swift
  var favoriteFruits1 = Set(["Orange", "Melon", "Apple"])
  var favoriteFruits2 = Set(["Apple", "Melon", "Orange"])
  favoriteFruits1 == favoriteFruits2							// true
  favoriteFruits1.elementsEqual(favoriteFruits2)	// false
  ```

### 집합으로서의 Set

- `A.isSuperset(of: B)` : A가 B의 superset인가
- `A.isStrictSuperset(of: B)` : 자기 요소 외 추가 요소가 최소 하나 이상 존재하는가

```swift
// 포함 관계 여부. 상위/하위 집합.
// group1 ⊇ group2
let group1: Set = ["A", "B", "C"]
let group2: Set = ["A", "B"]

// superset
group1.isSuperset(of: group2)
group1.isStrictSuperset(of: group2)
// strictSuperset - 자기 요소 외 추가 요소가 최소 하나 이상 존재해야 함
group1.isStrictSuperset(of: group1)

// subset
group2.isSubset(of: group1)
group2.isStrictSubset(of: group1)
group2.isStrictSubset(of: group2)
```

### Fundamental Set Operators

- `A.isDisjoint(with: B)` : A와 B가 공집합인가
- `A.intersection(B)` : A와 B의 공집합 반환
- `A.formIntersection(B)` : A에서 B의 요소를 제거(공집합 요소만 남기고 제거)
- `A.symmetricDifference(B)` : A와 B의 교집합의 여집합을 반환
- `A.formSymmetricDifference(B)` : A를 A와 B의 교집합의 여집합 요소들로 변경
- `A.union(B)` : A와 B의 합집합 반환
- `A.formUnion(B)` : A를 A와 B의 합집합 요소들로 변경
- `A.subtracting(B)` : A와 B의 차집합을 반환
- `A.subtract(B)` : A를 A에서 A와 B의 교집합을 제외한 요소들로 변경. 즉, A를 A와 B의 차집합 중 A의 요소들로 변경