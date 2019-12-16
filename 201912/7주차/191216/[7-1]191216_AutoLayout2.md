# Intrinsic Content Size

- 고유 컨텐츠 크기. Content를 온전하게 표현하기 위한 최소한의 공간.
- AutoLayout 작업 시 ICS를 이용해서 constraint를 자동으로 생성
- View에 따라 다른 형태를 가질 수 있음
  - `UIView` : Intrinsic Content Size가 없음
  - `UISlider` : Width만 ICS에 정해져 있음
  - `UILabel`, `UIButton`, `UISwtich`, `UITextField`... : Width, Height 모두 ICS에 정해져 있음
  - `UITextView`, `UIImageView` : ICS가 유동적으로 바뀔 수 있음(vary). 즉, content가 없을 때는 일반 `UIView`처럼 ICS가 없지만 content가 있을 때는 해당 content에 맞게 ICS를 갖게 됨. **두 가지 속성을 동시에 가짐**
    - `UIImageView`는 이미지를 넣기 전에는 ICS가 없지만, 이미지를 넣는 순간 그 이미지의 크기를 `UIImageView`의 크기로 설정함
- `UIView`같은 **Intrinsic Content Size가 없는 view**는 위치와 크기가 모두 auto layout으로 정해져야함
- `UILabel`같은 **Intrinsic Content Size가 있는 view**는 auto layout을 설정할 때 위치만 잡아줘도 내부 크기를 이용함

## CHCR

### Priority

- 각각의 constraint는 1~1000의 우선순위(priority)를 가짐. 더 높은 constraint가 우선적으로 적용됨
- Required(1000), High(750), Low(250) 등 미리 지정된 값으로 사용 가능
- 특정 순간에 constraint의 priority를 변경해서 적용될 constraint의 순서를 조절할 수 있음
- 우선순위가 높은 것부터 적용하고 우선순위가 낮은 것은 무시됨

```swift
// 직접 설정
UILayoutPriority(900)
UILayoutPriority(800)

// 미리 지정된 값 사용
UILayoutPriority.required			// 1000
UILayoutPriority.defaultHigh	// 750
UILayoutPriority.defaultLow		// 250

// Priority Set
view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
view.setContentCompressionResistancePriority(.required, for: .vertical)

// Priority Get
view.contentHuggingPriority(for: .horizontal)
view.contentCompressionResistancePriority(for: .vertical)
```

### Content Hugging

- View size가 더 늘어나지 않도록 **최대 크기를 제한**. 즉, content에 딱 맞게 view가 **늘어나지 않도록 제한**
- Content size보다 view size가 커질 수 있는 상황에서
  - Content Hugging Priority가 높으면 **content size에 맞게 view size를 조절**
  - Content Hugging Priority가 낮으면 공간이 남더라도 view size를 유지 
- Auto Layout으로 layout이 설정된 두 label(`Label1`, `Label2`)에 대해
  - `Label1`의 text가 삭제되어 content size가 줄어들 때, `Label1`의 CH를 높이면 `Label1`의 view size가 text에 맞게 줄어들고 `Label2`의 view size가 늘어남. **즉, `Label2`에 여유공간이 생김**
  - 반대로 `Label1`의 CH를 줄이면 상대적으로 `Label2`의 CH가 높아지므로 `Label2`의 view size가 text에 맞게 고정되고 `Label1`의 view size가 늘어남. **즉, `Label1`에 여유공간이 생김**

### Content Compression Resistance

- 더 줄어들지 않도록 **최소 크기를 제한**. 즉, content에 딱 맞게 view가 **줄어들지 않도록 제한**
- Content Size보다 view size가 작아질 수 있는 상황에서
  - Content Resistance Priority가 높으면 content가 잘리지 않도록 **view size를 content size에 맞춤**
  - Content Resistance Priority가 낮으면 content가 잘리더라도 view size를 유지
- Auto Layout으로 layout이 설정된 두 label(`Label1`, `Label2`)에 대해
  - `Label1`의 text가 추가되어 content size가 늘어날 때, `Label1`의 CR을 높이면 `Label1`의 글자가 잘리지 않도록 `Label1`의 view size가 늘어난 content size에 맞게 늘어나고 `Label2`는 글자가 잘리는 한이 있더라도 view size가 줄어듦. **즉, `Label2`의 글자가 잘림**
  - 반대로 `Label1`의 CR을 줄이면 상대적으로 `Label2`의 CR이 높아지므로 `Label2`의 글자가 잘리지 않도록 view size가 content size에 맞춰지므로 **`Label1`의 글자가 잘림

# Dynamic AutoLayout

- 동적 레이아웃 구성 방법
  1. `constant`, `multiplier`를 변경하는 방법
  2. Priority를 변경하는 방법
  3. `isActive` 활성화 상태를 변경하는 방법

## Constraint의 constant, multiplier를 변경하는 방법

- 추가한 `NSLayoutConstraint` 속성의 제약 조건을 변수로 두고 처리할 수 있음

  ```swift
  import UIKit
  class ViewController: UIViewController {
    @IBOutlet private weak var centerXConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      self.centerXConstraint.constant = 100
    }
  }
  ```

- `UIView.animate(withDuration:animations:)`를 이용해서 animation을 줄 수 있다
  - View는 layout이 변경되어 update해야 한다는 조건이 들어왔을 때만 다음 layout run loop에서 layout을 다시 잡으라고 시스템에 알려줄 수 있음
  - `self.view.setNeedsLayout()` : Layout을 다시 잡아야 한다고 시스템에게 알리는 역할. 특정 속성을 `true`로 설정해서 **다음 layout run loop에서** 해당 view hierarchy의 layout을 다시 잡을 수 있도록 설정함. `constraint.constant`를 변경하는 것이 `setNeedsLayout()`을 호출하는 효과
  - `self.view.layoutIfNeeded()` : Layout을 다시 잡아야 하는 상황이면 지금 즉시 update함. `setNeedsLayout()`을 호출하거나 `constraint` 값을 변경해서 update 속성이 `true`로 바뀌어있다면 **다음 loop을 기다리지 않고** 무조건 update함
  - **즉, layout update를 시스템이 해줄 때 까지 기다릴것인지, 아니면 지금 당장 update할 것인지의 차이**
  - Auto Layout이 나오면서 사용하게 된 method로, `frame`과는 다른 메커니즘을 갖고 있음. Auto layout과 frame은 다른 loop에서 동작하게 되므로 `frame`을 이용한 animation은 이 함수 없어도 적용되는 것
    - `frame`이 바뀔 때 : `viewWillLayoutSubviews()`, `viewDidLayoutSubviews()`가 호출됨
    - Constraint가 바뀔 때 : View에서는 `updateConstraints()`, ViewController에서는 `updateViewConstraints()` 호출

```swift
import UIKit
class ViewController: UIViewController {
  @IBOutlet private weak var centerXConstraint: NSLayoutConstraint!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
		UIView.animate(withDuration: 1) {
	    self.centerXConstraint.constant = 100
      self.view.layoutIfNeeded()	// 반드시 써야함
  	}
  }
}
```



## Priority를 변경해서 적용시키는 방법

- 특정 상황에 따라 다른 constraint를 지정하기 위해 우선순위를 변경해서 처리할 수 있음

  ```swift
  import UIKit
  class ViewController: UIViewController {
    @IBOutlet private weak var originConstraint: NSLayoutConstraint!	// priority Required(1000)
  	@IBOutlet private weak var moveConstraint: NSLayoutConstraint!	// priority High(750)
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
  
  		// 최초 설정되어 있는 priority 1000인 constraint 대신
  		// 이동된 위치로 설정하는 moveConstraint를 적용하려고 함
  		if condition {
  			// 상대적으로 moveConstraint의 priority가 높아지면서 적용되는 constraint 변경
        originConstraint.priority = .defaultLow		// Priority 250x
      }
    }
  }
  ```

## 활성 상태를 변경하는 방법

- `isActive = false`를 이용해서 활성화할 constraint를 선택할 수 있음. RC가 -1 되는 동작.

- `isActive = false`를 사용하려면 `IBOutlet` 변수를 `strong`으로 생성하거나 어딘가에 constraint에 대한 참조를 가지고 있어야 함. 또는 다시 그 constraint를 사용하려고 할 때 반드시 `true`로 설정해야함

- 코드로만 작성했다면 상관없지만 스토리보드에서 설정한 constraint를 `IBOutlet`으로 가져왔을 때 `false`로 설정한 뒤 값을 사용하려고 하면 오류

  ```swift
  import UIKit
  class ViewController: UIViewController {
    @IBOutlet private weak var originConstraint: NSLayoutConstraint!	// priority Required(1000)
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      originConstraint.constant = 100
      originConstraint.isActive = false	// 이 순간에 constraint가 제거되어 nil
    }
  }
  ```

# Size Classes

- **Size Classes**는 content 영역에 자동으로 할당되는 특성으로 view의 width와 height을 `regular`(넓은 공간)와 `compact`(제한된 공간)로 정의함
- View는 `regular`와 `compact`를 조합한 다음 네 가지 조합을 가질 수 있음
  - Regular Width, Regular Height
  - Compact Width, Compact Height
  - Regular Width, Compact Height
  - Compact Width, Regular Height
- 다양한 기기 size에서 iOS는 size classes를 기반으로 layout을 적용함. 가로모드를 사용하는 등 화면이 바뀌면 해당하는 size classes를 바탕으로 설정된 width와 height을 가져와서 content size를 구성
- 특정 기기에 맞추는게 아니라 regular, compact category에 해당하는 모든 기기에 대해서 적용할 수 있음
  - iPad : Regular Widtth, Regular Height
  - iPhone Max Model, iPhone XR
    - Portrait : Compact Width, Regular Height
    - Landscape : Regular Width, Compact Height
  - iPhone
    - Portrait : Compact Width, Regular Height
    - Landscape : Compact Width, Regular Height