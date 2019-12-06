# Initializer

- Designated Initializer(지정 생성자)
- Convenience Initializer(편의 생성자)
- Failure Initializer(실패 가능 생성자)
- Required Initializer(필수 생성자)
- Deinitializer(소멸자)

## Designated Initializer(지정 생성자)

- Class의 객체를 사용하기 전에 **모든 저장 프로퍼티가 반드시 초기화**되어야 함

- 초기화가 필요한 모든 저장 프로퍼티를 **단독으로 초기화 가능한** initializer. Designated Initializer를 호출하면 모든 프로퍼티가 초기화된 것이 보장됨

- Class에 반드시 하나 이상 존재함. `init()`을 따로 만들지 않아도 기본 생성자가 생성됨. 아무 동작도 안하니까 생략된 것

- Designated Initializer 안에서 또 다른 DI를 호출할 수 없음

  ```swift
  class Rectangle {
    var width: Int
    var height: Int
    var posX: Int
    var posY: Int
    
    init() {
  		self.width = 20
      self.height = 20
      self.posX = 0
      self.posY = 0
    }
    
    init(width: Int, height: Int, posX: Int, posY: Int) {
      self.width = width
      self.height = height
      self.posX = posX
      self.posY = posY
    }
  }
  ```

## Convenience Initializer(편의 생성자)

- 단독으로 모두 초기화할 수 없고 일부만 처리한 뒤 다른 생성자에게 나머지 부분을 위임할 수 있게 사용하는 생성자 

- 프로퍼티를 일부만 초기화한 상태에서 다른 `init`을 호출하여 나머지 저장 프로퍼티를 초기화해야함. 즉, 반드시 자기 자신이 가진 다른 생성자를 호출해서 모든 저장 프로퍼티를 완전히 초기화 시켜야함

- Convenience Initializer 안에서 또 다른 CI를 호출할 수도 있고 DI를 호출하기도 함

  ```swift
  class Rectangle {
    // Designated Initializer
  	init() { ... }
    init(width: Int, height: Int, posX: int, posY: Int) { ... }
    
    // Convenience Init
   	convenience init(posX: Int) {
      self.init()
      self.posX = posX
    } 
    
    convenience init(width: Int, height: Int) {
      self.init(width: width, height: height, posX: 10, posY: 10)
    }
  }
  ```

  - `self.init()`이 호출되지 않은 상태에서는 `self`를 사용할 수 없으므로 CI에서는 다른 DI 호출 후 변수 초기화를 별도로 진행해야함. 순서가 바뀌면 안된다.
  - CI에서 `self.init()`을 호출한 시점에는 모든 저장 프로퍼티가 초기화되어 있다는 것이 보장됨. 모든 저장 프로퍼티를 초기화한 후 다른 작업을 해야함

- 중복되는 초기화 코드를 줄이기 위해 사용

- 전체 초기화 과정 : **CI -> CI -> .... -> DI(최종)**

## Failure Initializer

- 인스턴스 생성 시 특정 조건을 만족하지 않으면 객체를 생성하지 않는 생성자

- 인스턴스 생성에 실패하면 `nil` 반환

  ```swift
  class Person {
    let name: String
    let age: Int
    
    init?(name: String, age: Int) {
      guard age > 0 else { return nil }
      self.name = name
      self.age = age
    }
  }
  ```

## Required Initializer

- 반드시 구현해야 하는 initializer. Subclass에서 부모 클래스의 init을 override하거나, sub class만 갖는 새로운 init을 작성할 때 sub class에 반드시 작성해야 하는 initializer

- 반드시 작성해야 하므로 override 키워드가 필요없음

  ```swift
  class Animal {
      let name: String
      let age: Int
      
      init(age: Int) {
          self.age = age
          self.name = "Tori"
      }
      required init(name: String) {
          self.name = name
          age = 3
      }
  }
  
  class Dog: Animal {
      let type: String
      
      init(type: String) {
          self.type = type
          super.init(name: "Tori")
      }
      
      required init(name: String) {
          self.type = "Poodle"
          super.init(name: name)
      }
  }
  ```

## Deinitializer

- 클래스 인스턴스가 메모리에서 해제될 때 호출되는 method

  ```swift
  class SomeClass {
      override init() {
          print("Initialized")
      }
      deinit {
          // 객체 메모리 해제 시 동작할 코드
          print("Deinitialized")
      }
  }
  
  func someFunction() {
      let someClass: Any = SomeClass()
      someClass
      // 함수 종료와 함께 객체가 메모리에서 해제
      // 클래스 인스턴스의 참조가 0이 되는 순간 해제되는 것
  }
  someFunction()
  ```

## Super Class Initializing

- 클래스에서는 CI부터 호출되기 시작해서 마지막에 DI로 초기화가 끝남

- Sub class의 DI가 마지막으로 호출될 때, **super class의 DI**도 호출해서 **sub class의 초기화가 끝나기 전에 super class가 모두 초기화**되어야 함. 즉, 상속 관계에서 **sub class는 자기 자신 이외에 super class의 저장 프로퍼티까지 초기화 해야 함**

  - Sub class는 super class의 **지정 생성자(Designated Initializer)**를 반드시 호출해야함.
  - Sub class에서 **super class의 CI는 호출 불가**. CI는 클래스를 직접 생성할 때만 사용할 수 있음. Override만 가능

  ```swift
  class Base {
    var someProperty: String
    
    init() {
      someProperty = "someProperty"
    }
    
    convenience init(someProperty: String) {
      self.init()
      self.someProperty = someProperty
    }
  }
  
  class Rectangle: Base {
    var width: Int
    var height: Int
    
    override init() {
      // Sub class를 먼저 초기화한 뒤
      width = 10
      height = 5
      
      // Super class를 초기화
      // 수퍼 클래스의 지정 생성자가 기본 생성자 하나만 있을 경우 자동 호출
  		super.init()   
      
      // Super class 초기화 시 편의 생성자는 호출 불가
  //    super.init(someProperty: "생성자 내에서 수퍼 클래스의 편의 생성자 호출 시 오류")
    }
    
    init(width: Int, height: Int) {
      self.width = width
      self.height = height
    }
  }
  ```

### 자식 클래스를 먼저 초기화하고 부모 클래스를 나중에 초기화해야 하는 이유 

- Sub class의 DI에서 먼저 프로퍼티 초기화를 끝낸 후, super class의 DI를 호출해야 함. 즉, **sub class의 초기화가 먼저 끝난 뒤 super class를 초기화**해야함

  - Super class의 DI에서 어떤 함수를 호출하고 있고, sub class에서 그 함수를 override하고 있는 경우, `super.init`을 통해 함수가 호출될 때는 sub class에서 override한 함수가 실행됨. **`super.init`을 호출한 주체가 sub class이기 때문.**
  - 이 때, sub class에서 아직 초기화되지 않은 프로퍼티가 override한 함수에서 사용된다면, 초기화되지 않은 변수를 사용하게 될 우려가 있음
  - 객체의 정적 타입을 super class 타입으로 정해도, **실제 들어가는 값**이 sub class 타입 인스턴스라면 sub class의 `init`이 먼저 호출되고 sub class가 `super class`의 `init`을 호출하게 되므로 같은 결과가 나옴
  - 이런 오류를 막기 위해 **Sub Class의 `init` 먼저 호출하고 나중에 Super Class의 `init`을 호출해야함**

  ```swift
  class Shape {
    var name: String
    var sides: Int
    
    init(sides: Int, named: String) {
      self.sides = sides
      self.name = named
      printShapeDescription()
    }
    
    func printShapeDescription() {
      print("Shape Name : \(self.name)")
      print("Sides : \(self.sides)")
    }
  }
  
  class Triangle: Shape {
    var hypotenuse: Int
    
    init(hypotenuse: Int) {
      self.hypotenuse = hypotenuse						// 자신의 프로퍼티 먼저 초기화
      super.init(sides: 3, named: "Triangle")	// 그 다음 super class 초기화
  
      // 만약 순서가 바뀐다면, self.hypotenuse가 초기화되지 않은 상태에서
      // override한 printShapeDescription 함수가 호출되므로 오류가 발생할 것
      // self.hypotenuse = hypotenuse						
      // super.init(sides: 3, named: "Triangle")
    }
    
    override func printShapeDescription() {
      print("Hypotenuse : \(self.hypotenuse)")
    }
  }
  
  let rectangle = Shape(sides: 4, named: "Rect")
  // Shape에 있는 init 호출 => Shape의 printShapeDescription 호출
  
  let triangle = Triangle(hypotenuse: 12)
  // Triangle의 init 호출 => Triangle에서 override한 함수로 호출
  
  let triangle1: Shape = Triangle(hypotenuse: 12)
  // Shape 타입이지만, 실제로 인스턴스가 생성될 때는 Triangle의 init이 호출되므로
  // Triangle에서 override한 함수가 호출
  ```

- Super class에 생성자가 기본 생성자(`init()`)밖에 없으면 sub class에서 `super.init()`을 직접 호출하지 않아도 시스템이 자동 호출함. **기본 생성자가 외에 다른 생성자**를 갖는다면 명시적으로 호출해야함

- 즉, **Sub Class에서는 항상 자기 자신의 저장 프로퍼티를 모두 초기화하는 작업이 우선되어야 한다**

## Initializer Specification

### Using property in Init

- Initializer에서 아직 초기화되지 않은 저장 프로퍼티에는 접근할 수 없음

- 모든 저장 프로퍼티가 초기화된 후에 프로퍼티 및 함수를 사용 가능함. 그 함수에서 초기화되지 않은 변수를 사용하게 될 위험 때문에 함수도 프로퍼티 초기화가 완성된 후 사용해야함

  ```swift
  class Chart {
      var height: Int
      var xPosition: Int
      
      init(height: Int, xPosition: Int) {
          self.height = height
          print(self.height)    // 초기화 이후 접근
        	
        	// xPosition을 초기화하기 전에 접근하려고 하면 오류
          // print(self.xPosition)
          
        	// 프로퍼티가 완전히 초기화되지 않았을 때 함수 호출 불가ㅣ
          //    self.printValues()     // 저장 프로퍼티 전체 초기화 이전
      }
      
      func printValues() {
      }
  }
  ```

### Extension Initializer

- `extension`에서 initializer를 추가할 때는 **DI는 추가할 수 없고 CI만 추가할 수 있음**. 원래 기능의 확장 개념이므로 원래 갖고 있던 DI를 이용해서 초기화하는 CI만 추가할 수 있는 것

  ```swift
  class Rectangle {
      var height: Int
      var xPosition: Int
      
      init(height: Int, xPosition: Int) {
          self.height = height
          self.xPosition = xPosition
      }
  }
  
  extension Rectangle {
      convenience init(height: Int) {
          self.init(height: height, xPosition: 10)
      }
      
      // Extension 내에서는 Convenience Initializer 만 가능
      //  init(xPosition: Int) {
      //    self.height = 10
      //    self.xPosition = xPosition
      //  }
  }
  ```

  