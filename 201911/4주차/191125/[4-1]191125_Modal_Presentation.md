# View Controller Modal

- `present(_:animated:completion:)` : 다른 view controller로 화면 전환
- `dismiss(animated:completion:)` : 현재 view controller를 띄웠던 view controller로 다시 돌아감
- View Controller 사이에 **화면 전환 방식**을 설정할 수 있음

## Data Transfer to View Controller

### presentingViewController

- 나를 띄워준 view controller. 즉, **`present`를 호출했던 view controller**
- 현재 view controller를 띄워준 view controller가 없다면 `nil`
  - `dismiss(animated:completion:)`은 원래 `presentingViewController?.dismiss(animated:true)` 같은 방식으로 접근해야함. 현재 view controller를 `present`한 view controller에서 복귀까지 수행
  - `presentingViewController?.presentingViewController.dismiss(animated:true)`로 쓰면 두 단계를 한번에 돌아감

### presentedViewController

- 내가 띄운 view controller. 즉, **`present`를 호출해서 현재 화면에 보여주고 있는 view controller**
- `present`한 view controller가 없다면 `nil`
- `present`를 호출하기 전에는 항상 `nil`이므로 `present` 호출과 순서를 지켜야 함

### Transfer data to own's property

- `view`같이 `UIViewController`가 갖고 있는 것에는 `presentingViewController`로 바로 접근해서 사용할 수 있지만, `UIViewController`를 상속받는 `ViewController` class에서 선언한 변수에는 **type casting**을 이용해서 접근해야함

  ```swift
  class ViewController: UIViewController {
    ...
   	var value = 0
   	...
    func presentOtherView() {
      let nextVC = NextViewController()
      present(nextVC, animated: true)
    }
  }
  
  class NextViewController: UIViewController {
    func someFunction() {
      // presentingViewController가 ViewController인지 확인
      // ViewController라면 해당 클래스의 변수에 접근
    	(presentingViewController as? ViewController)?.value = 10
    }
  }
  ```

# Card-Style Modal Presentation

- iOS13부터 화면 전환 시 기본으로 적용되는 modal presentation 방식

- `UIModalPresentationStyle`에 추가된 `case`

  ```swift
  public enum UIModalPresentationStyle: Int {
    case fullScreen
    case pageSheet
    case formSheet
  
    //...
    
    @available(iOS 13.0, *)
    case automatic	// card-style
  }
  ```

- 세로 모드일 땐 card-style이지만 가로 모드에서는 full-screen 형태

- `UIPickerViewController` 같은 system controller는 기본값을 full-screen으로 적용하기 위해 **automatic** 속성을 제공

- 일반 controller들은 card-style transition을 사용하지만, 카메라나 이미지 선택화면 등은 full-screen으로 자동 설정하기 위함

- 기존에는 화면을 닫는 버튼을 반드시 추가해야 했지만, **아래로 내리는 제스처**를 이용해서 화면을 닫을 수 있게 됨

## Card(Sheet)-Style Lifecycle

- Card-Style(Sheet) transition을 사용할 때는 full-screen과 view controller life cycle이 다르게 적용됨

### Present

- **Full-screen 방식**은 `presentingViewController`에서 **`viewDisappear()`** 관련 method가 호출됨
- **Card-Style 방식**은 `presentingViewController`에서는 호출되지 않고 `presentedViewController`에서만 **`viewAppear()`** 관련 method가 호출됨
- Card-Style 방식은 화면 전환 시 이전 화면이 완전히 사라지지 않고 남아있는 것으로 처리함
- View Controller를 여러 개 전환시켜도 `presentingViewController`들은 모두 `viewDisappear()` method가 호출되지 않음. `dismiss`도 마찬가지

### Dismiss

- **Full-screen 방식**은 `presentingViewController`로 돌아갈 때 다시 화면에 나타나므로 **`viewAppear()`** 관련 method가 호출됨
- **Card-Style 방식**은 `presentingViewController`가 애초에 화면에서 사라진 것이 아니므로 다시 돌아갈 때도 `viewAppear()` 관련 method가 호출되지 않음
- 이전 화면으로 돌아가면서 처리해야 할 동작이 있다면, 현재 화면의 `viewDisappear()` 관련 method에서 처리해야함

### Dismiss with Gesture

- Card-Style 방식부터는 `dismiss` 버튼 없이도 **제스처**로 `dismiss` 동작을 할 수 있게 됨
- View controller의 `.isModalInPresentation` 속성을 `true`로 설정하면 제스처로 닫을 수 없게 함. 애니메이션은 나오지만 실제로 닫히지 않음

### UIAdaptivePresentationControllerDelegate

- iOS 8부터 제공되던 delegate였지만 많이 사용되지 않았음. 

- iOS 13부터 제스처를 이용한 presentation 방식이 도입되면서 제스처 관련 method들을 이용해서 view controller의 life cycle을 관리할 수 있게 되었다

  ```swift
  class ViewController: UIViewController {
    func presentVC() {
      let nextVC = NextViewController()
      // 화면 전환할 view controller에서 제스처를 이용한 dismiss를
      // 관리하기 위한 delegate 설정
      nextVC.presentationController.delegate = self
    }
  }
  
  extension ViewController: UIAdaptivePresentationControllerDelegate {  
    
    // .isModalInPresentation이 true이거나 shouldDismiss가 false를 반환할 때 호출. 즉, 제스처를 이용한 dismiss를 막았을 때 호출됨
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController)
  
    // .isModalInPresentation이 false일 때 제스처를 이용한 dismiss를 허용할 지 여부를 반환
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool
  
    // shouldDismiss가 true를 반환하면 제스처를 이용한 dismiss 시작
    // willDismiss 이후 viewWillDisappear - viewDidDisappear 호출
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController)
  
    // 제스처를 이용한 dismiss가 끝나고 화면이 완전히 사라진 뒤 호출
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController)
    
  }
  ```

![image-20191125192506102](/Users/cskim/Developer/docs/ios-TIL/201911/4주차/191125/assets/image-20191125192506102.png)

- 내리다가 중간에 취소하면 `viewWillDisappear()`만 호출되고 `viewDidDisappear()`는 호출되지 않음. Disappear가 호출되었기 때문에 다시 `viewWillAppear()` - `viewDidAppear()`가 호출
