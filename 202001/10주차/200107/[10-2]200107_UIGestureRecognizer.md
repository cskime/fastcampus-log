# UIGestureRecognizer

- `UITapGestureRecognizer` : 탭(Tap) : ~0.1sec
- `UILongPressGestureRecognizer` : 오래누르기(LongPress) : > 0.5 sec
- `UIPanGestureRecognizer` : 드래그(Pan)
- `UIPinchGestureRecognizer` : 확대/축소(Pinch)
- `UIRotationGestureRecognizer` : 회전(Rotation)
- `UISwipeGestureRecognizer` : 밀기(Swipe)
- `UIScreenEdgePanGestureRecognizer` : 화면 모서리 드래깅(ScreenEdgePan)

## State

- Discrete : 제스처가 인식되었을 때 action metnod가 정확히 한 번만 호출되는 것
- Continuous : 한번 제스처가 인식된다면 action method가 계속 호출되는 것

## Usage

- View에 올려서(`view.addGestureRecognizer()`) view가 인식하면 ViewController에 있는 action method를 호출하도록 함(target-action)

  ```swift
  override func viewDidLoad() {
    super.viewDidLoad()
    let tapGesture = UITapGestureRecognizer(target: self,
                                          action: #selector(handleTap(_:))
                                         )
  	view.addGestureRecognizer(tapGesture)
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    // code..
  }
  ```

- 일반 view가 아니라 imageView같은 다른 view들은 `userInteractionEnabled`를 `true`로 활성화 해야 함

### Tap

- 탭(Tap) : 눌렀다 떼는 동작. Tap이 3이면 3번을 눌렀다 떼야 하는 것

- 터치(Touch) : 눌렀다 떼는 등의 구분 없이 그냥 터치. Touch가 3이면 세 손가락으로 터치하는 것

  ```swift
  tapGesture.numberOfTapsRequired			// Gesture 실행에 필요한 tap 횟수
  tapGesture.numberOfTouchesRequired	// Gesture 실행에 필요한 touch 수
  ```

### Rotation

- 두 손가락으로 회전하는 제스처 사용

- `rotation` : 회전 각(radian)

- `velocity` : 회전하는 속도

  ```swift
  rotationGesture.rotation
  rotationGesture.velocity
  ```

- View를 회전시킬 때 `rotation` 값은 계속 증가하기 때문에 엄청 빨리 돌게됨. 회전 시키는 만큼만 돌게 하려면 계속 `rotation`을 초기화 시켜 줘야 한다.

  ```swift
  @IBAction private func handleRotateGesture(_ sender: UIRotationGestureRecognizer) {
      view.transform = view.transform.rotated(by: sender.rotation)
      sender.rotation = 0	// 회전각(radian)이 누적되지 않도록 0으로 초기화
  }
  ```

### Swipe

- `UISwipeGestureRecognizer`는 하나의 gesture가 하나의 방향만 가질 수 있다. 둘 이상의 방향으로 gesture를 사용하려면 `UISwipeGestureRecognizer`를 사용할 제스처 방향 만큼 추가해야 한다.

- `up`, `down`, `left`, `right`

  ```swift
  @IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
      switch sender.direction {
      case .left:
          print("Left")
      case .right:
          print("Right")
      case .up:
          print("Up")
      case .down:
          print("Down")
      default:
          print("Unknown : \(sender.direction.rawValue)")
      }
  }
  ```

### Pan

- Swipe와 달리 방향 상관없이 연속적인 드래그

- `UISwipeGestureRecognizer`와 함께 사용할 수 없으므로 둘 중 하나를 `enabled = false` 또는 삭제해야함

  ```swift
  @IBAction private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
  	// Gesture가
    guard let dragView = sender.view else { return }
      let transition = sender.translation(in: dragView.superview)
      
      if sender.state == .began {
          initialCenter = dragView.center
      }
      
      if sender.state != .cancelled {
          imageView.center.x = initialCenter.x + transition.x
          imageView.center.y = initialCenter.y + transition.y
      } else {
          imageView.center = initialCenter
      }
  }
  ```

### Long Press

- 길게 누를 때 제스처

- 유지해야 하는 최소 시간을 정함

  ```swift
  longPressGesture.minimumPressDuration
  longPressGesture.numberOfTapsRequired
  longPressGesture.numberOfTouchesRequired
  ```

# Touch Event Handling

- 화면을 터치할 때 event를 이용해 기능을 구현할 수 있다.
- `touchesBegan(_:with:)` : View touch가 시작될 때 한 번만 호출
- `touchesMoved(_:with:)` : Touch한 뒤 움직이면 연속적으로 호출됨
- `touchesEnded(_:with:)` : Touch한 손가락을 떼면 touch 종료되면서 한 번만 호출
- `touchesCancelled(_:with:)` : 기타 상황에서 touch가 취소될 때 한 번만 호출

## UITouch

- Touch 정보를 담고 있는 객체

- `location(in:)` : Touch가 발생한 view에서 touch point 반환

- `previousLocation(in:)` : 직전 touch의 위치 반환

  ```swift
  guard let touch = touches.first else { return }
  let previousTouchPoint = touch.previousLocation(in: touch.view)
  let currentTouchPoint = touch.locatioin(in: touch.view)
  ```

# Methods

- `view.frame.contains(_:)` : `CGPoint`가 `CGRect` 안에 포함되는지 여부를 반환하는 함수

- `CGAffineTransform` : 2D graphic에서 affine 변환. View의 원래 크기 등으로부터 변환함

  ```swift
  view.transform = view.transform.scaledBy(x: 2, y: 2)	// scale 연산
  view.transform = view.transform.rotated(by: 3.14)			// 회전(radian)
  view.transform = view.transform.translatedBy(x: 0, y: 100)	// 위치 변화
  view.transform = CGAffineTransform.identity			// 원래 모습으로
  ```

- 진동

  ```swift
  import AudioToolbox.AudioServices
  
  private func vibrate() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
  }
  ```