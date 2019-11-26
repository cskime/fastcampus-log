# UIAlertController

- `UIAlertController(title:message:preferredStyle:)`로 생성
  - `preferredStyle` : `UIAlertController.Style` enum 입력
  - `.alert` : 화면 가운데 나타나는 알림창
  - `.actionSheet` : 화면 밑에 나타나는 알림창
- `UIAlertAction(title:style:handler:)`로 alert에서 사용할 버튼(action) 생성
  - `style` : `UIAlertAction.Style` enum 입력
  - `.cancel` : 취소버튼으로 사용할 수 있게 제공. 오른쪽 또는 가장 아래에 위치. Action sheet에서는 별도 영역에 제공
  - `.default` : 기본 동작
  - `.destructive` : 사용자에게 데이터가 날아갈 수 있거나 하는 위험한 작업임을 알려주기 위해 빨간색 버튼으로 나타남

```swift
// Alert controller 생성
let alert = UIAlertAction(title: "Title", message: "Message", preferredStyle: .alert)

// Alert에 추가할 action 생성
let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: nil)

// Alert controller에 action 추가
for action in [okAction, cancelAction, delegateAction] {
  alert.addAction(action)
}

// Alert controller로 화면 전환. Alert도 하나의 전체 화면을 갖는 controller이기 때문에 present 사용
present(alert, animated: true)
```

- Alert에 textField 추가하기
  - `alert.addTextField(configurationHandler:)` : Alert에 text field를 추가함. `configurationHandler`를 통해 추가하는 textField의 속성 설정
  - 추가된 textField들은 `alert.textFields?[index]`를 이용해서 추가된 순서대로 가져올 수 있음

```swift
// TextField 추가
alert.addTextField {
  $0.placeholder = "ID"
}
alert.addTextField {
  $0.placeholder = "Password"
}

// 추가한 textField 사용
alert.textFields?[0]			// ID textField
alert.textFields?[1]			// Password textField
```

