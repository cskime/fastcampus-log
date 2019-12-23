# UINavigationController

- 여러 개의 `UIViewController`를 `Navigation Stack` 에 담아서 각 `UIViewController`의 `root view`를 화면에 나타내는 컨트롤러
- **주의 : 기본적인 `frame`, `bounds`, `alpha`등의 값을 바꾸거나 view hierarchy 구조를 바꾸면 안됨**
- `viewControllers` : `UINavigationController`가 관리하는 `UIViewController`들의 집합(stack)
- `topViewController` : `viewControllers` stack의 가장 위에 있는 `rootViewController`
- `visibleViewController` : `viewControllers`에서 현재 보여지는 `UIViewController` object
- `navigationBar` : `UINavigationBar` 의 `delegate`
- `toolBar` : `UIToolBar` object
- `delegate` : Custom Delegate Object

## UINavigationBar

- `backBarButtonItem` or `leftBarButtonItem`
- `titleView`
- `rightBarButtonItem`

## Presented View Controllers

- `present` & `dismiss` : Container View Controller가 아닌 전체 화면을 전환하는 방법
  - `present(_:animated:completion:)`
  - `dismiss(animated:completion:)`
- `push` & `pop` : `viewControllers` stack에 넣어서 Container View Controller과 관리하도록 하는 방법
  - `navigationController?.pushViewController(_:animated:)`
  - `navigationController?.popViewController(animated:)`

# Usage

## Storyboard

- **[Editor] - [Embed In] - [Navigation Controller]** 를 선택하면 스토리보드에서 선택하면 ViewController에 Navigation Controller를 붙일 수 있음
- `Prefers Large Title` : Navigation Controller에서 title에 있는 글자가 큰 글자 title로 표시됨
- `barTintColor`
- `backgroundColor`
- 다음 화면으로 segue를 설정할 때 **show** 방식으로 설정
  - **Show** : `UINavigationController` 를 사용할 땐 `pushViewController(_:animated:)` 를 실행시키고, `UINavigationController` 를 사용하지 않을 때는 자동으로 `present(_:animated:completion:)` 을 실행하도록 함

- **스토리보드에서 만들어진 것을 코드로 불러올 때**

  - `instantiateInitialViewController()` : `identifier` 없이 스토리보드의 entry point가 연결되어 있는 `UIViewController`를 가져옴
  - `instantiateViewController(withIdentifier:)` : 미리 지정해 둔 식별자를 이용해서 가져오는 방법

  ```swift
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  let initlaiVC = storyboard.instantiateInitialViewController()
  let someVC = storyboard.instantiateViewController(withIdentifier: "Identifier")
  ```

## Code

- 생성 - `UINavigationController`가 entry point

  ```swift
  window = UIWindow(frame: UIScreen.main.bounds)
  let firstVC = ViewController()
  let navigationController = UINavigationController(rootViewController: firstVC)
  window?.rootViewController = navigationController
  window?.makeKeyAndVisible()
  ```

- 화면 전환

  - `present(_:aniimated:completion:)` : Present Modally 방식으로만 화면을 전환시킴
  - `show(_:sender:)` : `UINavigationController` 유무에 따라 **push**와 **present** 방식 중 하나를 알아서 골라서 사용함
  - `navigationController?.pushViewController(_:animated:)` : `UINavigationController`에서만 사용할 수 있음. `viewControllers` 스택에서 현재 VC의 다음 번쨰 VC로 화면을 전환시킴

- 되돌아오기

  - `dismiss(_:animated:)` : Present Modally 방식으로 화면을 전환했을 때, 이전 화면으로 되돌아가기
  - `popViewController(animated:)` : **push** 방식으로 화면을 전환했을 때 이전 화면으로 되돌아가기
  - `popToRootViewController(animated:)` : `viewController` stack의 제일 처음 VC(`rootViewController`)로 바로 되돌아가기

- `UINavigationBar`

  - `title` : `UIViewController`가 기본으로 갖고 있는 속성. NavigationBar의 title 설정

  - `UINavigationBar`의 title을 크게 만들기(iOS 11 이상)

    - `navigationController?.navigationBar.prefersLargeTitles` : `UINavigationController`와 연결된 `viewController`에 있는 VC들에 일괄 적용
    - `navigationItem.largeTitleDisplayMode` : VC별로 각각 다르게 설정

  - `UIBarButtonItem(title:style:target:action:)` : `leftBarButtonItem` 또는 `rightBarButtonItem`에 추가할 버튼 생성

    - `title` : 이름
    - `style` : `.plain` or `.done` : 볼드체 차이
    - `target` : `action` method를 갖고 있는 참조
    - `action` : Callback Method. `#selector()` 사용

    ```swift
    UIBarButtonItem(barButtonSystemItem:target:action:)
    UIBarButtonItem(barButtonSystemItem:target:action:)
    ```

    

  - `UINavigationItem`

    - `rightBarButtonItem`, `leftBarButtonItem` : 오른쪽 / 왼쪽 버튼 설정
    - `rightBarButtonItems`, `leftBarButtonItems` : 오른쪽 / 왼쪽 버튼 여러 개 설정
    - `backBarButtonItem` : 다른 화면 전환 시 되돌아오는 버튼 설정
    - `UIBarButtonItem` object를 `rightBarButtonItem`과 `leftBarButtonItem` 양 쪽에 넣을 수 없다. 한쪽에만 넣어야함

    ```swift
    let barButtonItem = UIBarButtonItem(title: "Next", style: .plain, target self, action: #selector(touched(_:)))
    navigationItem.rightBarButtonItem = barButtonItem		
    navigationItem.leftBarButtonItem = barButtonItem		
    navigationItem.backBarButtonItem = barButtonItem		
    navigationItem.rightBarButtonItems
    ```

    