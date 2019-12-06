# Singleton

- 특정 클래스의 인스턴스에 접근할 때 항상 동일한 인스턴스만 반환하도록 하는 설계 패턴

- App에서 유일하게 하나만 필요한 객체를 만들 때 사용

- 한번 생성하면 프로그램이 종료될 때 까지 항상 메모리에 상주하기 때문에 꼭 필요한 경우에만 사용해야함

- Singleton 인스턴스는 `static`으로 만들어짐. `static` 변수는 **지연 생성**되기 때문에 실제로 사용하려고 할 때 초기화됨

  ```swift
  class NormalClass {
    var value = 0
  }
  let norm1 = NormalClass()
  let norm2 = NormalClass()
  norm1.value = 10
  norm2.value = 20
  
  // 서로 다른 인스턴스가 할당되어 있기 때문에 변경한 값이 따로 적용됨
  norm1.value		// 10
  norm.value		// 20
  
  ///
  
  class SingletonClass {
    static let shared = SingletonClass()
    var value = 0
  }
  let singleton1 = SingletonClass.shared		// 지연 생성. 이 때 인스턴스 생성 후 할당
  let singleton2 = SingletonClass.shared		// singleton1에서 만든 인스턴스가 할당됨	
  singleton1.value = 10
  singleton2.value = 20
  
  // 같은 인스턴스가 할당되기 때문에 변경 사항이 모두 적용됨
  singleton1.value	// 20
  singleton2.value	// 20
  
  Singleton.shared.value = 30
  singleton1.value	// 30
  singleton2.value	// 30
  ```

- SIngleton 패턴을 사용해도 일반 클래스처럼 새로운 객체를 만드는 것도 가능함. Singleton으로 만든 인스턴스만 사용하게 강제하고 싶다면 **`init()`을 `private`**으로 설정해서 외부에서의 접근을 제한함(**Unique Singleton**)

  ```swift
  class Singleton {
    static let shared = Singleton()  
    var value = 0
    
    private init() { }
    
    init(value: Int) {
      self.value = value
    }
  }
  let singleton1 = Singleton.shared
  let singleton2 = Singleton()		// init()은 private이기 때문에 외부에서 접근할 수 없음. 생성 불가.
  let singleton3 = Singleton(vallue: 10)	// init(value: Int)는 접근할 수 있음. 생성 가능.
  ```

