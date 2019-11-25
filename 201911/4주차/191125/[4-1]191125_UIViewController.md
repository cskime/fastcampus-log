# UIViewController

- 주요 역할
  - View Management : Root view hierarchy management
  - Data Marshaling : Controller between View and Data
  - User Interactions : Touch event handling with target-action and delegate
  - Resource Management : View controller life cycle, memory resource management
  - Adaptivity : Adapt for various device size, orientation, etc

## View Management

- Root view iew hierarchy 아래의 view들을 관리
- Root view를 중심으로 화면에 표시하기 위한 view를 root view hierarchy에 추가

### Content View Controller

- View를 단독으로 관리하는 view controller. Content를 화면에 표현하는 역할
- `UIViewController`, `UITableViewController`, `UICollectionViewController`

### Container View Controller

- 직접 view를 관리하지 않고, **child view controller**들을 통해 화면을 관리
- 자체 view 위에 child view controller들의 root view hierarchy를 올려서 view 관리
- 각 content가 아닌 **root view**만 관리함. Container 디자인에 따라 root view의 크기를 조정
- `UINavigationController`, `UITabbarController`, `UIPageVIewController`, `UISplitViewController`

## Data Marshaling

- **MVC(Model - VIew - Controller)** 패턴의 **Controller**
- Data를 view에 표현하기 위한 형태로 **변환**하여 제공. View와 Data 사이의 중개 역할

## User Interactions

- **Responder 객체**로서 이벤트를 받아 처리할 수 있지만 **지양하는 방법**
- View가 받은 touch event를 연관된 객체에 **action method**(`UIButton` 등 `UIControl` 객체들의 **target-action** ) 또는  **delegate**(`UITextFieldDelegate`)를 이용해서 전달.
- 뷰가 그 자신의 터치 이벤트를 연관된 객체에 action 메서드나 delegate로 전달

## Resource Management

- View controller가 생성한 모든 view와 관련된 객체들은 모두 view controller의 책임(root view의 view hierarchy에 포함된 view들)
- **View controller life cycle**에 따라 생성되었다가 자동 소멸되지만 **ARC**에 맞게 관리 필요
- `didReceiveMemoryWarning` method에서 꼭 유지하지 않아도 되는 자원들을 정리할 필요가 있음. 

## Adaptivity

- View의 표현을 책임지고 현재 환경에 적절한 방법으로 적용되도록 할 책임을 가짐
- 기기의 사이즈, 가로/세로모드 등에 따른 화면 구성을 관리해야 함

# View Controller Hierarchy

## Root View Controller

- App은 화면에서 가장 기본이 되는 `UIWindow` 객체를 갖고, 이 객체 위에 화면을 표시함
- `UIWindow` 그 자체로는 content를 갖지 못하고, **하나의 root view controller**를 통해 content를 표현함. Root view controller의 root view에 content를 표시

## Presented View Controller

- `present` 동작으로 화면을 전환시킬 때 기존 화면을 덮는 완전히 새로운 화면을 나타냄
- View controller 위에 또 다른 View Controller가 올라가는 방식

## Child View Controller

- Container view controller의 `childViewController`로 추가된 view controller들은 container view controller가 갖는 root view 위에 `childViewController`의 view를 올려서 표현함
- View Controller 위에 덮는 방식이 아니라 container view controller의 root view에 child view controller의 view hierarchy를 디자인에 따라 올리는 것
- `UINavigationController`는 navigation bar를 갖는 root view를 갖고, **stack** 형식으로 `childViewController`를 관리함
- `UINavigationController`로 연결되는 child view controller들은 화면 전환 시 각각의 root view hierarchy를 갈아끼우면서 전환

# View Controller Life Cycle

- `UIViewController`는 일정한 **생명 주기**를 갖고 content를 표현하고 data를 처리함

## LoadView

- View를 메모리에 load하기 시작할 때 호출됨
- 실제 프로젝트에서는 시스템이 기본 root view를 setting하므로 `override`하지 않도록 권장

## ViewDidLoad

- View가 메모리에 load된 직후 호출됨
- 메모리 상에만 있고 화면에는 표시되지 않은 상태

## ViewWillAppear

- 화면이 사용자에게 나타나기 직전에 호출됨

## ViewDidAppear

- 화면이 사용자에게 보여진 직후 호출됨

## ViewWillDisappear

- 화면이 사라지기 직전에 호출됨

## ViewDidDisappear

- 화면이 사라진 직후에 호출됨

## ViewDidUnload

- View가 화면에는 없지만 메모리에 남아있는 경우,  low memory warning이 발생하면 `didReceiveMemoryWarning` method를 통해 message를 받고 view에 `nil`을 할당
- View가 메모리에서 해제된 직후 호출됨

## Modal Presentation Life Cycle

- `FirstViewController`와 `SecondViewController` 사이에 화면이 전환될 때 view의 life cycle

### `FirstViewController`가 화면에 나올 때

1. First - `viewDidLoad()` : 메모리에 올림
2. First - `viewWillAppear()` : 화면에 나타내는 작업(rendering) 시작
3. First - `viewDidAppear()` : 화면에 나타남

### `SecondViewController`로 화면 전환

1. Second - `viewDidLoad()` : 메모리에 올림
2. First - `viewWillDisappear()` : 첫 번째 화면은 가려지므로 화면에서 사라질 작업 시작
3. Second - `viewWillAppear()` : 두 번쨰 화면을 화면에 나타내는 작업 시작
4. Second - `viewDidAppear()` : 화면에 나타남
5. First - `viewDidDisappear()` : 첫 번쨰 화면이 완전히 가려짐

### `FirstViewController`로 돌아감

1. Second - `viewWillDisappear()` : 두 번째 화면을 내릴 준비
2. First - `viewWillAppear()` : 첫 번째 화면을 다시 화면에 나타내는 작업 시작
3. First - `viewDidAppear()` : 화면에 나타남
4. Second - `viewDidDisappear()` : 두 번쨰 화면이 완전히 가려짐

- `SecondViewController`에서 `FirstViewController`로 돌아오면 `FirstViewController`는 아직  메모리에 로드되어 있기 때문에  `viewDidLoad()`가 다시 호출되지 않고 `viewWillAppear()`부터 호출됨

![image-20191125190003481](/Users/cskim/Developer/docs/ios-TIL/201911/4주차/191125/assets/image-20191125190003481.png)