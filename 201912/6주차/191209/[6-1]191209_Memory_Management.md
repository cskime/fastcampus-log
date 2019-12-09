# Memory Management

- 메모리를 효율적으로 사용하기 위해 사용되지 않는 메모리는 system에 반환해야함
- MRR / MRC : Objective-C에서 사용하던 수동 메모리 관리 방식
- ARC : 2011년부터 사용된 자동 메모리 관리 방식

## Managing Manually

### GC(Garbage Collection)

- 정기적으로 Garbage Collector가 동작하여 더 이상 사용되지 않는 메모리를 system에 반환하는 방식
- **Runtime**에 주기적으로 작동해서 그때그때 사용되지 않는 메모리를 반환
- 사용되지 않는 메모리를 찾기 위해 runtime에 **heap을 스캔**해야함. 프로그램을 사용하면서 일시적인 멈춤 현상이 일어날 수 있음

### MRR(Manual Retain-Release) / MRC(Manual Reference Counting)

- 기존 objective-c에서 사용하던 메모리 관리 방식

- 메모리가 필요할 때 **`alloc`**, **`retain`**, 필요 없을 때 **`reelase`**를 명시적으로 사용해서 직접 메모리를 관리해야 함

- `alloc`, `retain`, `release`를 명시적으로 호출함으로서 개발자가 직접 참조 카운트를 관리함

  ```objective-c
  int main(int argc, const char * argv[]) {
    Person *man = [[Person alloc] init];	// count 1
    [man doSomething];
    
    [man retain];				// count 2
    [man doSomething];
    
    [man release];		// count 1
    [man release];		// count 0
    
    return 0;
  }
  ```

### Leak vs Dangling Pointer

- Leak : 메모리 누수. **Release보다 Retain/Alloc이 많을 경우** 필요없는 데이터에 메모리가 계속 할당되어 있어서 메모리 낭비
- Dangling Pointer : 허상, 고아 포인터. **Release가 더 많을 경우** 실제로 없는 메모리에 접근하려는 오류가 생김.
- `alloc`, `retain`과 `release`의 짝을 잘 맞춰야 함. 그로 인해 메모리 관리가 까다롭고 어려워져서 실수할 가능성도 높아짐

## ARC(Automatic Reference Counting)

- **자동(Automatic) 메모리 관리 방식(RC, Reference Counting)**

- **Compile Time**에 컴파일러가 메모리 관리 코드를 적절한 위치에 자동으로 삽입함

- ComplieTime에 미리 메모리 관리 계획을 세워 둔 뒤 실행하는 것이므로 Garbage Collector 처럼 runtime에 heap을 스캔하면서 발생하는 일시멈춤 현상이 없다

  ```swift
  // My Code
  class Point {
    var x: Double
    var y: Double
    init(x: Double, y: Double) {
      self.x = x
      self.y = y
    }
  }
  
  let point1 = Point(x: 0, y: 0)
  let point2 = point1
  point2.x = 5
  
  // Generated Code
  class Point {
    var refCount: Int		// generated
    var x: Double
    var y: Double
  	init(x: Double, y: Double) {
      self.x = x
      self.y = y
    }
  }
  
  let point1 = Point(x: 0, y: 0)
  retain(point1)	// generated
  let point2 = point1
  point2.x = 5
  release(point1)	// generated
  release(point2)	// generated
  ```

- 컴파일러가 메모리 관리 타이밍을 직접 정하기 때문에 개발자가 코딩 자체에 집중할 수 있도록 도와줌
- ARC는 **클래스 인스턴스**에만 적욛됨. 즉, **heap**에 저장되는 타입에만 적용됨

## 동작 방식

- Class 인스턴스를 생성하면 메모리의 heap 영역에 할당됨
- 인스턴스에 참조하는(인스턴스의 Heap영역 주소값을 갖는) 변수에 대해 **참조 카운트**가 증가
- 즉, ARC는 **heap과 관련되어 있을 때** 참조 카운팅에 의한 메모리 해제를 자동으로 해 주는 것
- 변수가 메모리에서 해제되거나 다른 값을 갖게 되면 참조 카운트 감소
- Closure의 순환참조 같은 경우, closure이기 때문에 발생하는 것이 아니라 **closure가 클래스 같은 참조 타입 안에서 사용될 때 self가 안에서 사용되면서 일어나는 문제**. Struct 안에서 사용된다면 문제가 발생하지는 않음.
- Closure의 순환 참조가 발생하면 closure의 **획득 목록**에서  `self`의 참조 방법을 `weak`로 변경해야함

## Strong, Weak, Unowned

- Strong : 명시적으로 nil 대입 필요. teacher?.student = nil
- Unowned : 자동으로 deinit. nil 처리 된 속성에 접근하면 런타임 에러 발생. Dangling pointer 유지
- Weak  : 자동으로 deinit. nil 처리 된 속성에 접근하면 nil 반환

|                    |                  Strong                   |                 Weak                 |                           Unowned                            |
| :----------------: | :---------------------------------------: | :----------------------------------: | :----------------------------------------------------------: |
| Reference Counting |                     O                     |                  X                   |                              X                               |
|   Variable(var)    |                     O                     |                  O                   |                              O                               |
|   Constant(let)    |                     O                     |                  X                   |                              O                               |
|      Optional      |                     O                     |                  O                   |                              X                               |
|    Non-Optional    |                     O                     |                  X                   |                              O                               |
|   Memory Release   |            명시적으로 nil 할당            |      auto deinit<br />nil 할당       |         auto deinit<br />메모리 주소는 계속 갖고있음         |
| Available Problem  | Strong Reference Cycle<br />(Memory Leak) | 인스턴스 해제 후 접근하려고 하면 nil | 인스턴스 해제 후 접근하려고 하면 오류(dangling pointer)<br />(Dangling Pointer) |

```swift
class Teacher {
  var student: Student?
  deinit {
    print("Teacher is being deinitialized")
  }
}

class Student {
  // strong, unowned, weak
//  let teacher: Teacher
//  unowned let teacher: Teacher	
  weak var teacher: Teacher?
  
  init(teacher: Teacher) {
    self.teacher = teacher
  }
  deinit {
    print("Student is being deinitialized")
  }
}

/* Teacher의 student property와 Student의 teacher property가 모두 'strong'이면 */
var teacher: Teacher? = Teacher()   								// Teacher Count 1, Student Count 0
var student: Student? = Student(teacher: teacher!)  // Teacher Count 2, Student Count 1
teacher?.student = student  												// Teacher Count 2, Student count 2

teacher = nil   // Teacher Count 1, Student count 2
student = nil   // Teacher COunt 1, Student count 1

/* Student의 teacher property가 참조를 카운트하지 않는다면 */
var teacher: Teacher? = Teacher()   								// Teacher Count 1, Student Count 0
var student: Student? = Student(teacher: teacher!)  // Teacher Count 1, Student Count 1
teacher?.student = student  												// Teacher Count 1, Student count 2

teacher = nil   // Teacher Count 0, Student count 1 => Teacher release
student = nil   // Teacher COunt 0, Student count 0 => Student release
```







