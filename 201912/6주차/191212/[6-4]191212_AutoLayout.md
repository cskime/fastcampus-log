# Auto Layout Basic

- View에 주어진 제약조건(constraint)에 따라 **크기와 위치를 동적으로 계산**해서 배치하는 것
- 외부 또는 내부 변화에 동적으로 반응하여 UI 구성
  - 외적 변화 요소(External Changes)
    - 서로 다른 기기 및 스크린 크기
    - 기기 회전(Portrait, Landscape)
    - Split View 사용 시
  - 내적 변화 요소(Internal Changes)
    - 앱에서 보여지는 컨텐츠의 변화
    - 국제화(텍스트, 날짜/숫자, RTL 등) 지원. 나라별 글자 길이, 날짜 표현 방식 등이 달라지는 것에 따른 변환.
    - RTL : 글을 쓰는 방식. (leading, trailing)
    - Dynamic Type 지원(글꼴 크기 등)

## Laying out a UI

### Frame Based Layout

- 원점의 위치(`origin`)와 크기(`size`)를 통해 view가 그려질 영역을 계산함
- 장점 : 가장 유연하고 빠른 성능. 모든 view에 대해 개별적으로 설정하고 관리할 수 있음
- 단점 : 동적 변화에 대한 설계 및 debug, 유지 관리가 어려움

### Auto resizing masks

- Storyboard - Size Inspector에서 `AutoResizing`을 통해 설정
- View의 위치 및 크기가 변할 때 `AutoResizing`에서 설정한 부분에 해당하는 여백(Margin)을 고정시킴
- `SuperView`의 크기가 변할 떄 `SubView`의 위치, 크기가 어떻게 될 것인지 설정하는 것.(Top Margin, Bottom Margin 등)
  - `Top`, `Bottom`, `Left`, `Right` : Subview의 Superview에 대한 상하좌우 여백(margin) 설정
  - `width`, `height` : Superview 위치, 크기 변화 시 subview의 크기(가로, 세로 길이) 고정 설정
- 세세하게 조정하지 않아도 되는 상황에서는 간단하게 동적인 UI 구현 가능

### Auto Layout

### Auto Layout

- **제약 조건(constraint)**을 이용해서 UI 정의
- View간의 관계를 설정해서 크기와 위치를 계산. A View가 B View로붜 얼마나 떨어져있는지 등.
- 장점 : 내/외부 변경 사항에 동적으로 반응할 수 있음
- 단점 : Frame 기반에 비해 느린 성능. 성능이 중요시되는 상황에서는 Frame 기반으로 UI를 구성해야함

<br>

## Auto Layout

- Auto Layout은 하나 설정하고 나면 **관련된 모든 view**에서 auto layout을 설정해 줘야 함
- Size Inspector에서 설정한 constraint를 확인하고 constant를 변경하거나 target view를 지정할 수 있음

###  Tools

- Stack : 선택한 객체들을 하나의 `UIStackView`로 반환
- Align : **정렬**에 관한 제약사항(constraint) 설정
- Pin : **객체 간 상대적 거리 및 크기**에 관한 제약사항(constraint) 설정
- Resolve Issues : Auto Layout 관련 문제 해결
  - Update Frames : Auto Layout을 설정한 뒤 임의로 위치를 이동시키거나 크기를 변경했을 때, auto layout에 의해 설정된 위치 및 크기로 다시 돌려놓는 것
  - 선택된 view 또는 전체 view에 대해 constraint 삭제, 컴파일러가 제안하는 constraint로 변경하는 등 동작

### Attributes

- `Top`, `Bottom`, `Left` or `Leading`, `Right` or `Trailing`
  - Respecting Language Direction : 나라마다 글이 시작하는 방향이 왼쪽/오른쪽으로 다름. View의 방향을 언어 방향에 맞추기 위해 `leading`, `trailing` 사용. 
  - 사용하는 언어가 달라졌을 때 언어의  `RTL`, `LTR`이 바뀌어도 `leading`과 `trailing`을 사용하면 자동으로 맞춰지게 됨
  - Respecting Language Direction 설정을 해제하면 `left`, `right`로 사용할 수 있다
- `Width`, `Height`
- `Center X`, `Center Y`
- `Baseline`

### Usage

- First Item : Constraint를 **설정하려는 view**

- Second Item : Constraint를 설정하기 위한 **기준이 되는 view**

- Relation

  - Equal
  - Less than Equal 
  - Greater than Equal

- Constant : First Item과 Second Item 사이 관계를 고정된 값(constant)으로 표현

- Multiplier : First Item과 Second Item 사이 관계를 비율로서 표현

- Priority : Constraint 간에 충돌이 일어나면 정해진 우선순위가 더 높은 constraint를 우선적으로 적용함

- Identifier

- Placeholder : Storyboard 상에서만 확인하고 실제 실행하면 제약을 제거하는 것(Remove at build time)

- Installed : Installed가 체크되어 있어야 실제로 적용됨

- `FirstItem`.`Attributes` = `Multiplier` x `SecondItem`.`Attributes` + `Constant`

- A View의 오른쪽 변과 B View의 왼쪽 변이 10pt만큼 떨어지도록 설정

  BView.leading = 1.0 x AView.trailing + 10.0

## Layout Guide

- iOS 7부터 **Top Layout Guide / Bottom Layout Guide** 사용. 
- iOS 11부터 **Safe Area Layout Guide** 사용

### Safe Area

- 실제 content가 온전하게 될 수 있는 영역

- Tool / Navigation bar 영역, 노치 영역 등을 제외한 영역

- **Safe Area Insets**

  - iPhone 8까지는 Frame을 이용해서 위치를 잡을 때 status bar를 가리지 않도록 status bar의 frame을 사용할 수 있었음

    ```swift
    // Status bar에서 20만큼 떨어진 지점
    let minY = UIApplication.shared.statusBarFrame.size.height + 20
    ```

  - iPhone X 부터는 상단 노치와 **하단 인디케이터 바**까지 신경써야 하기 때문에 `safeAreaInsets`를 사용함

    ```swift
    // SafeAreaInsets : (top, left, bottom, right)
    view.safeAreaInsets
    
    // Before iPhone X : (20, 0, 0, 0)
    // After iPhone X : (44, 0, 34, 0)
    ```

  - `safeAreaInsets`은 `viewSafeAreaInsetsDidChange()` method가 호출된 이후에 값이 초기화되므로 `safeAreaInsets`은 `viewSafeAreaInsetsDidChange()`가 호출된 이후 시점에서 사용해야함

    - ViewController Life Cycle에서 layout 시점 : `viewDidLoad()` -> `viewWillAppear()` -> `viewSafeAreaInsetsDidChange()` -> `viewWillLayoutSubviews()` -> (Root view)`layoutSubviews()` -> `viewDidLayoutSubviews()` -> `viewDidAppear()`

    ```
    ViewDidLoad: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    ViewWillAppear: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    ViewSafeAreaInsetsDidChange: UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
    ViewWillLayoutSubviews: UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
    ViewLayoutSubviews : UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
    ViewDidLayoutSubviews: UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
    ViewDidAppear: UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
    ```

# Auto Layout Anchors

## NSLayoutConstraint

- Storyboard에서 constraint를 설정했을 때 생기는 선 하나에 대한 객체. `FirstItem`과 `SecondItem`에 대한 `attribute`, `multiplier`, `constant` 등을 직접 설정

  ```swift
  NSLayoutConstraint(item: subview,		// First Item
                     attribute: .leading,
                     relatedBy: .equal,
                     toItem: view,		// Second Item
                     attribute: .leadingMargin,
                     multiplier: 1.0,
                     constant: 0.0).isActive = true
  ```

## NSLayoutAnchor

### Horizontal Layout Anchors

- `NSLayoutXAxisAnchor`
  - X축(수평선)에 관련된 제약조건
  - `leadingAnchor`, `trailingAnchor`, `leftAnchor`, `rightAnchor`, `centerXAnchor`
- `NSLayoutYAxisAnchor`
  - Y축(수직선)에 관련된 제약조건
  - `topAnchor`, `bottomAnchor`, `centerYAnchor`, `firstBaselineAnchor`, `lastBaselineAnchor`

### Dimension Layout Anchors

- `NSLayoutDimension`
  - View의 크기를 정의하는 제약조건
  - `widthAnchor`, `heightAnchor`

### Usage

- iOS 9.0 이상부터 코드상에서 Auto Layout을 쉽게 사용하기 위해 사용됨

  ```swift
  view.subview.constraint(equalTo: view.leadingMargin).isActive = true
  ```

- `NSLayoutAnchor`를 사용할 때는 반드시 `translatesAutoresizingMaskIntoConstraints` 속성을 `false`로 설정해야 함. Auto resizing mask는 시스템에서 자동으로 constraint로 변환해서 적용하는데, 우리가 직접 constraint를 적용하려는 것이므로 자동 변환 옵션을 해제하는 것

  ```swift
  view.translatesAutoresizingMaskIntoConstraints = false
  ```

- `isActive = true`를 설정해야 constraint가 적용됨. `NSLayoutConstraint` 객체에 일일히 `isActive`를 설정하기 어렵다면 `NSLayoutConstraint`의 `activate(_:)` method로 한 번에 설정할 수도 있다.

  ```swift
  // isActive를 통한 제약조건 활성화
  firstView.translatesAutoresizingMaskIntoConstraints = false
  
  firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
  firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
  firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
  firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
      
  // activate를 통한 제약조건 활성화
  secondView.translatesAutoresizingMaskIntoConstraints = false
  
  NSLayoutConstraint.activate([
        secondView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 40),
        secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 40),
        secondView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -40),
        secondView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -40),
      ])
  ```

