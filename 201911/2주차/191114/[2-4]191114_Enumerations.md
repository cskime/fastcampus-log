# Enumerations

- 연관된 값의 그룹에 대해 공통 타입을 정의한 뒤 type-safe하게 해당 값들을 사용 가능

- 여러 값들이 하나의 공통된 주제로 연관되어 있음을 쉽게 알아볼 수 있게 값을 관리함

- `enum` 타입으로 사용됨. `case`의 값 자체는 타입을 갖지 않음

  ```swift
  enum CompassPoint {		// Pascal Case
    case north					// Camel Case
    case south
    case east
    case west
  }
  var directionToHead1 = CompassPoint.west
  var directionToHead2: CompassPoint = .west
  directionToHead1 = .east
  directionToHead2 = .south
  ```

## Matching Enumeration Values

- `enum`과 `switch`를 같이 사용하면 각각의 case에 대해 matching하기 쉬움

  ```swift
  switch directionToHead1 {
    case .north:
    case .south:
    case .east:
    case .west:
  }
  ```

## Associated Values

- `enum`의 `case` 이름에는 특정 타입이 없지만 관련 값을 할당할 수 있음

  ```swift
  enum OddOrEven {
    case odd(Int)
    case even(Int)
  }
  var number = OddOrEven.even(20)
  number = OddOrEven.odd(13)
  
  // 선언할 때 할당한 값을 사용
  switch number {
  case .odd(let x): print("홀수 :", x)
  case let .even(x): print("짝수 :", x)
  }
  ```

- 하나의 `case` 이름에 여러 개의 연관 값을 넣을 수 있음

  ```swift
  enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
  }
  
  var productBarcode = Barcode.upc(8, 85909, 51226, 3)
  productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
  
  // 연관값을 꺼내서 사용
  switch productBarcode {
  case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
  case let .qrCode(productCode):
    print("QR code: \(productCode).")
  }
  ```

- Associated value는 `enum` 인스턴스와 연관된 값이기 때문에 `raw value`처럼 직접 값에 접근할 수는 없다. `enum` 내에서 별도의 method를 구현하고 그 안에서 `self`에 대해 `switch` 등을 이용해 `case`의 연관값을 꺼내와야한다.

  ```swift
  enum OddOrEven {
    case odd(Int)
    case even(Int)
    
    func get() -> Int {
      switch self {
        case .odd(let x):
        return x
        case .even(let x):
        return x
      }
    }
  }
  var number = OddOrEven.even(20)
  number = OddOrEven.odd(13)
  number.get()		// 13
  ```

## Raw Value

- `enum`의 `case` 이름은 특정 값을 가지진 않지만 특정 값을 가질 수 있음
- `Int`, `String` 등 `enum`의 타입을 지정해서 raw value의 타입을 지정
- `enum`에 지정하는 raw value는 유일해야함. 중복되면 안됨

### Raw value 할당

- `Int` 타입의 `enum`에서는 `case`에 값을 주지 않으면 0부터 차례대로 값이 증가.

- `case`의 raw value를 직접 지정한 경우, 이후 지정하지 않은 값은 지정한 값부터 1씩 증가

  ```swift
  enum Weekday: Int {
    case sunday, monday, tuesday, wednesday = 2, thursday, friday, saturday
    // 0, 1, 2, 2, 3, 4, 5 값이 들어가있음
  }
  
  Weekday.wednesday		 				// wednesday
  Weekday.wednesday.rawValue	// 2
  ```

- `case`의 raw value가 `String` 타입이면 별도로 값을 지정하지 않을 때 `case`의 이름을 raw value로 가짐

  ```swift
  enum WeekdayName: String {
    case sunday, monday, tuesday, wednesday, thursday, friday = "fri", saturday = "sat"
  }
  
  WeekdayName.monday
  WeekdayName.monday.rawValue		// "monday"
  WeekdayName.friday.rawValue		// "fri"
  ```

- `rawValue`를 이용한 초기화 가능. `rawValue`가 있으면 해당 `case` 반환. 없다면 `nil` 반환.

  ```swift
  enum PlanetIntRaw: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto
  }
  
  PlanetIntRaw(rawValue: 5)		// jupiter
  PlanetIntRaw(rawValue: 7)		// uranus
  PlanetIntRaw(rawValue: 10)	// nil
  
  // rawValue를 이용해 초기화한 enum case를 binding
  // 다른 언어와 호환되도록 할 때 5번째 값을 가져온다는 식으로 사용?
  if let somePlanet = PlanetIntRaw(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
      print("Mostly harmless")
    default:
      print("Not a safe place for humans")
    }
  } else {
    print("There isn't a planet at position \(positionToFind)")
  }
  ```

## Nested

- `enum` 안에 함수를 선언해서 사용 가능

  ```swift
  enum Device: String {
    case iPhone, iPad, tv, watch
    
    func printType() {
      switch self {
      case .iPad, .iPhone, .tv:
        print("device :", self)
      case .watch:
        print("apple Watch")
      }
    }
  }
  
  let iPhone = Device.iPhone
  iPhone.printType()
  ```

- `enum`안에 또 다른 `enum`을 정의할 수 있음. `enum` 내부에서 별도로 몇 가지 종류에 대한 경우를 따질 때. 그 `enum` 안에서만 사용될 `enum` 정의

  ```swift
  enum Wearable {
    enum Weight: Int {
      case light = 1
      case heavy = 2
    }
    enum Armor: Int {
      case light = 2
      case heavy = 4
    }
    
    case helmet(weight: Weight, armor: Armor)
    case boots
    
    func info() -> (weight: Int, armor: Int) {
      switch self {
      case .helmet(let weight, let armor):
        return (weight: weight.rawValue * 2, armor: armor.rawValue * 5)
      case .boots:
        return (3, 3)
      }
    }
  }
  var woodenHelmet = Wearable.helmet(weight: .light, armor: .heavy)
  woodenHelmet.info()
  
  // 바깥에서 Weight에 접근하려면 반드시 Wearable enum을 통해서만 접근 가능
  // enum에서의 캡슐화
  var wearableWeight = Wearable.Weight.light
  ```

  

- 어떤 값이 뭘 의미하는지 알려줄 수 있는 방법

## Mutating

- `enum`은 value type. `enum`, `struct` 등.

- value type은 내부의 값을 바꾸도록 허용하지 않음

- 내부의 값을 변경하기를 허용한다는 의미로, 내부 값을 변경할 가능성이 있는 함수에 `mutatin`을 붙임

- `enum`에서 사용하는 함수가 어떤 로직을 통해 내부의 값을 변경하는 경우(어떤 조건에 따라 상태를 바꾸려고 하는 등)가 생긴다면 그 함수에 `mutating`을 붙여야함.

  ```swift
  enum Location {
    case seoul, tokyo, london, newyork
    
    // 내부(self)의 값을 .london으로 바꾸려고 하니까 mutating 필요
    func travelToLondon() {
      self = .london
    }
   	
    mutating func travelToTokyo() {
      self = .tokyo
    }
    
    mutating func travelToCity() {
          switch self {
          case .seoul:
              self = .tokyo
          case .tokyo:
              self = .london
          case .london:
              self = .newyork
          case .newyork:
              self = .seoul
          }
      }
  }
  
  var location = Location.seoul
  location		// seoul
  
  location.travelToTokyo()
  location		// tokyo
  
  location.travelToCity()
  location		// london
  
  location.travelToCity()
  location		// newyork
  ```

## Recursive Enumerations

- 자기 자신을 참조하는 `enum` 형식

- `enum`안에서 자기 자신의 타입을 사용하려는 경우 각각의 `case` 또는 `enum` 전체에 `indirect` 키워드를 붙여주면 사용할 수 있음

  ```swift
  indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)  // 자신의 타입
    case multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  
  enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)  // 자신의 타입
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  ```

- 연산 결과를 저장하고 있다가 한번에 실행시키는 등 지연 실행 경우 사용할 수 있겠다

  ```swift
  indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
  }
  
  let five = ArithmeticExpression.number(5)
  let four = ArithmeticExpression.number(4)
  let sum = ArithmeticExpression.addition(five, four)
  let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
  ```

  