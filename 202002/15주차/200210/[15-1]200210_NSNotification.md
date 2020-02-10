# NSNotification

- `NSNotificationCenter`에 method를 `selector`로 등록해 두고, `name`에 해당하는 `Notification`이 발생했을 때 `selector` method를 호출한다

- `UITextField` 등을 사용할 때 키보드 Frame, Animation 등의 정보를 `NotificationCenter`를 통해 받을 수 있다.

  ```swift
  func addKeyboardNotification() {
    let notiCenter = NotificationCenter.default
    notiCenter.addObserver(
      self,
      selector: #selector(keyboardWillShowNotification(_:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    notiCenter.addObserver(
      self,
      selector: #selector(keyboardWillShowNotification(_:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  @objc func keyboardWillShowNotification(_ noti: Notification) {
    guard let userInfo = noti.userInfo,
    let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
    let duration = serInfo[UIResponder.keyboardAnimationDurationuserInfoKey] as? TimeInterval else { return }
   	// frame : 키보드 size, origin. frame.y == view.height이라면 가려진 상태
    // duration : 키보드가 올라올 때 다른 View들을 같은 속도로 올려주고 싶다면
    //   duration을 사용해서 animation을 줄 수 있다.
  }
  ```

- Keyboard 관련 `Notification`.() `NSNotification.Name` type)

  - `UIResponder.keyboardWillHideNotification`
  - `UIResponder.keyboardDidHideNotification`
  - `UIResponder.keyboardWillShowNotification`
  - `UIResponder.keyboardDidShowNotification`
  - `UIResponder.keyboardWillChangeFrameNotification`
  - `UIResponder.keyboardDidChangeFrameNotification`

- Keyboard 관련 `UserInfoKey`

  - `UIResponder.keyboardIsLocalUserInfoKey` : `NSNumber` of `BOOL`
  - `UIResponder.keyboardFrameBeginUserInfoKey` : `NSValue` of `CGRect`
  - `UIResponder.keyboardFrameEndUserInfoKey` : `NSValue` of `CGRect`
  - `UIResponder.keyboardAnimationCurveUserInfoKey` : `NSNumber` of `NSUInteger`(`UIViewAnimationCurve`)
  - `UIResponder.keyboardAnimationDurationUserInfoKey` : `NSNumber` of `Double`