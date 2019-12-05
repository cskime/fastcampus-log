#Type Casting

- Swift에서 변수가 갖는 타입은 크게 두 가지로 나눌  수 있음
  - 정적 타입 : 변수를 처음 생성하면서 **컴파일러가 정하는** 타입
  - 동적 타입 : 변수에 **실제로 들어있는 값**의 타입
- Type check 또는 type casting에서 **컴파일 타임에는 정적 타입을 사용하고 런타임에는 동적 타입을 사용**

## Type Check

- `type(of:)` : 현재 타입을 확인하는 method. **런타임**에 실행되기 때문에 **실제 값의 타입(동적 타입)**을 반환

  ```swift
  type(of: "10")		// String.Type
  if type(of: "10") == String.Type {		// Comparison
    print("String Type")
  }
  
  let sample: Any = SampleClass()
  type(of: sample)	// SampleClass.Type
  ```

- `is` : 어떤 값 또는 변수의 타입이 같은지 체크해서 `true` or `false` 반환

  ```swift
  let number = 1
  number is Int		// true
  
  let sample: Any = SampleClass()
  sample is SampleClass		// true
  ```

### Generic

- 값이 들어오는 순간에 타입을 결정하는 방법.

  ```swift
  func printGenericInfo<T>(_ value: T) {
    let type = type(of: value)
    print("'\(value)' is '\(type)' type")
  }
  ```

## 상속 관계에서 Type Check

- 상속 관계에 있는 부모 클래스(super class)와 자식 클래스(sub class) 사이에는 **Sub IS-A Super** 관계가 성립하기 때문에, sub class는 super class의 타입에 포함될 수 있다. 즉, Sub class는 단 하나의 super class를 갖기 때문에 sub에서 super로 포함될 수 있다. **`sub is super`의 결과는 `true`**

- 하지만, super class는 여러 개의 sub class를 가질 수 있기 때문에 특정 sub class 타입으로 포함될 수 없다. 즉, super class는  sub class 타입에 포함될 수 없기 때문에 **`super is sub`의 결과는 `false`**

- 형제(sibling) 관계에 있는 클래스들은 전혀 관련이 없기 때문에 상호 타입에 포함될 수 없다.

- 즉, **자식 is 부모** 또는 **자신 is 자신**인 경우에만 결과가 `true`

  ```swift
  class Human { }
  class Baby: Human { }
  class Student: Human { }
  class UniversityStudent: Student { }
  
  let student = Student()
  // true. Student는 Human이다. (sub IS-A super)
  student is Human
  // false. Student는 Baby가 될 수 없다. (Sibling)
  student is Baby
  // true. Student는 Student 자신.
  student is Student				
  // false. Student는 University Student일 수도 있지만 아닐 수도 있다.
  student is UniversityStudent	
  ```

- `type(of:)`는 **동적 타입(runtime에 정해지는 타입)**을 반환한다. Class에서도 객체에 명시된 타입이 아니라 **실제로 들어있는 인스턴스의 타입**을 반환한다.

  ```swift
  let human: Human = Student()		// Static Type : Human, Dynamic Type : Student
  type(of: human)		// Student.Type(Dynamic Type)
  human = Baby()		// Static Type : Human, Dynamic Type : Baby
  type(of: human)		// Baby.Type
  ```

- 이 때, `human`은 컴파일 타임에 `Human` 타입이기 때문에 `Human` 클래스에는 없는 `school` property에 접근할 수 없다.

  ```swift
  human.name		// Human.name
  human.school	// error
  
  // 컴파일 타임에서 human은 Human Type(static type)이므로 sub class들을 할당할 수 있음
  // Sub class인 Baby, UniversityStudent 타입은 Super class인 Human타입에 포함될 수 있음
  human = Baby()	
  human = UniversityStudent()
  ```

- Super class에서 sub class의 속성을 접근해서 사용할 수 있도록 **컴파일 타임에서 정적 타입을 sub class의 타입으로 변경**해야 함. 이것을 **타입 캐스팅**이라고 한다.

  ```swift
  var james = Studnet()					// Static Type : Student, Dynamic Type : Student			
  james = UniversityStudent()		// Static Type : Student, Dynamic Type : UniversityStudent
  
  // 컴파일 타임에 정적 타입(Student)의 속성 school에 접근 가능
  james.school		
  // 컴파일 타임에 정적 타입(Student)이기 때문에 UniversityStudent 타입의 속성에는 접근 불가
  james.univName
  
  // 컴파일 타임에 UniversityStudent의 속성에 접근하기 위해, 정적 타입을 동적 타입으로 변경함
  if let univStudent = james as? UniversityStudent {
  	univStudent.univName  
  }
  ```

## Type Casting

- 어떤 변수의 **정적 타입**을 다른 타입으로 변환하여 컴파일 타임에 변경된 타입을 적용시키는 것
- 실제로 들어있는 값의 타입(**동적 타입**)을 비교해서 변환 가능하면 컴파일 타임에 **정적 타입**이 변환된 값을 반환함
- `as` : 타입 변환이 확실하게 가능한 경우(up casting, 자기 자신 등) 사용 가능
- `as?` : 강제 타입 변환을 시도하고 성공하면 Optional 값으로 반환. 실패시 `nil`
- `as!` : 강제 타입 변환을 시도하고 성공하면 Optional을 unwrapping. 실패 시 오류

### Up Casting

- 상속 관계에서 sub class를 super class의 타입으로 변환하는 것

- Sub class에서 super class 타입으로 변환하는 것은 항상 성공함. `as` 사용

  ```swift
  class Shape {
    var color = UIColor.black
    
    func draw() {
      print("draw shape")
    }
  }
  
  class Rectangle: Shape {
    var cornerRadius = 0.0
    override var color: UIColor {
      get { return .white }
      set { }
    }
    
    override func draw() {
      print("draw rect")
    }
  }
  
  class Triangle: Shape {
    override func draw() {
      print("draw triangle")
    }
  }
  
  let rect = Rectangle()	// Static Type : Rectangle, Dynamic Type : Rectangle
  rect.color
  rect.cornerRadius		
  
  (rect as Shape).color		// Success
  (rect as Shape).cornerRadius		// Fail. 
  // Up casting : 'rect'에 실제로 들어있는 값의 타입(정적 타입(Rectangle))을 Shape으로 변환
  // 캐스팅을 통해 rect의 static type이 Shape으로 변경됨. 
  // Shape에는 'cornerRadius' 프로퍼티가 없으므로 오류
  ```

### Down Casting

- 상속 관계에서 super class를 sub class의 타입으로 변환하는 것

- Super class에서 sub class 타입으로의 변환은 실패할 가능성이 있으므로 `as?` 또는 `as!` 사용

  - Sub class는 super class가 무조건 하나지만 super class는 sub class가 몇개인지 컴파일러가 알 수 없기 때문에 어떤 class로 변환할 수 있다는 확신이 없음. 즉, 컴파일러가 알 수 없기 때문에 오류
  - `as?` : 변환 시 실패할 가능성을 가짐. 실패하면 `nil`을 반환하고, 성공하면 변환 결과를 `Optional()`로 감싸서 반환
  - `as!` : 변환 시 실패할 가능성은 열어두지만 실제로는 실패하지 않을 것이 분명해서 변환 결과를 바로 unwrapping

- `as?`, `as!`는 부모 자식 관계로 묶여서 서로 관련 있는 타입들끼리만 사용할 수 있게 됨. 관련 없는 타입으로 캐스팅하려고 하면 오류

- Sub class에는 super class에 없는 값을 가질 수 있음. Super class에서 sub class의 속성에 접근하려면 **정적 타입**을 변환해야함. 런타임에 실제 들어있는 인스턴스의 타입을 비교하여 변환하고 결과를 반환하는 것

  ```swift
  // FirstVC에서 SecondVC로 화면전환
  class FirstVC: UIViewController { 
    var value = 0
  }
  
  class SecondVC: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()
      	// FirstVC의 value에 접근
      	if let firstVC = presentingViewController as? FirstVC {
          // do something
        }
  	}
  }
  ```

  - `presentingViewController`의 **정적 타입**은 `UIViewController`, **동적 타입**은 `FirstVC`
  - Down casting(`as?`) : `presentingViewController`의 **동적 타입**을 `FirstVC`와 비교하고, 변환 가능하면 `presentingViewController`의 **정적 타입**을 `FirstVC`로 변환한 결과를 `firstVC`에 할당
  - `presentingViewController`의 **정적 타입**과 **변환 타입**이 같으므로 변환 가능, `firstVC` 사용 가능해짐

### 정적 타입과 동적 타입

- 정적 타입 : 실제로 겉으로 보여지는 타입, 컴파일 할 때 신경쓰는 타입
- 동적 타입 : 실제로 들어있는 값의 타입, 런타임에서 신경쓰는 타입