# UITabBarController

- checkbox : 여러 개 선택
- radio-stype : 하나만 선택할 수 있는 것. `UITabBarController`는 하나의 `UIViewController`만 선택할 수 있도록 관리함
- 화면 아래쪽에서 몇 가지 `UIViewController`를 사용할 수 있도록 함
- `viewControllers` : 여러 개의 자식 VC를 가짐
- `customizableViewControllers`
- `selectedViewController` : 현재 선택된 VC
- `delegate` : Custom Delegate Object

## UITabBar

- `UITabBarController`와 결합해서 사용하기도 하지만 별도로도 사용 가능함
- `UITabBar` : 앱의 모드를 변화하기 위한 것
- `UIToolBar` : 현재 VC의 컨텐츠에 관련된 action을 수행하기 위한 것

## UITabBarItem

- `UITabBar`에 있는 각각의 `item`을 표현하는 object
- `shaodwImage`
- `selectedTintColor`
- `translucent`
- `barStyle`
- `barTintColor` or `backgroundImage`
- Item 개수가 5개 이상이 되면 **More** Item을 통해 다른 item에 접근
  - `customizableViewControllers` : More에서 `UITabBar`에 변경 가능한 item으로 사용될 수 있는 VC

### Life Cycle

- 최초 실행 시 첫 화면 VC만 메모리에 올라가고 `viewDidLoad()` 호출. 다른 VC는 메모리에 로드되지 않은 상태
- 다른 Item을 직접 선택해야 `viewDidLoad()` 호출
- 다른 item을 선택할 때는 직전 VC는 화면에서 사라지기만 하고(`viewDisappear()`) 메모리에는 남아있음

# Usage

## Storybard

- **[Editor] - [Embed In] - [Tab Bar Controller]**로 선택한 VC에 연결
- 여러 개의 VC를 `UITabBarItem`으로 설정하기 위해 **RelationShip Segue**의 `view controllers`로 연결

### UITabBarItem

- `title` : Item 아이콘 아래 title 설정
- `image` : **Tab Bar Item**에 있는 **System Image**를 설정하면 title도 바뀌기 때문에, title과 image를 별도로 설정하려면 **Bar Item**에서 별도로 image를 설정해야함

## Code

- `UIViewController`가 갖고있는 `tabBarItem` 생성 -> `UITabBarController`의 `viewControllers`에 추가

  - `UITabBarItem(tabBarSystemItem:tag:)`
  - `UITabBarItem(title:image:tag:)`
  - `UITabBarItem(title:image:selectedImage:)`

  ```swift
  // 1. UITabBarItem 생성
  let firstVC = ViewController()
  firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "person.circle"), tag: 0)
  
  let secondVC = SecondViewController()
  secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "folder.fill"), tag: 1)
  
  let thirdVC = ThirdViewController()
  thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "paperplane"), tag: 2)
  
  // 2. UITabBarController에 추가
  let tabBarController = UITabBarController()
  tabBarController.viewControllers = [firstVC, secondVC, thirdVC]
  
  // 3. UIWiindow 생성
  window = UIWindow(frame: UIScreen.main.bounds)
  window?.rootViewController = tabBarController
  window?.backgroundColor = .systemBackground
  window?.makeKeyAndVisible()
  ```