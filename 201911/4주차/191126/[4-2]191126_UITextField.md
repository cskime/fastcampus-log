# UITextField

## Attribute Settings

- Dynamic Type

  - TextField의 글자 크기가 설정에서 바꾼 system font size에 맞게 자동으로 조절됨

  - Automatically Adjusts Font 옵션 설정

  - Font를 미리 지정된 text style로 설정해야함

    ```swift
    // Automatically Adjusts Font in Interface Builder
    textField.adjustsFontForContentSizeCategory = true
    // Font를 미리 지정된 text style로 설정
    textField.font = .preferredFont(forTextStyle: .body)
    ```

- Text Font

  - `.systemFont(of:)` : 글자크기 조절
  - `.systemFont(of:weight:)` : 글자크기와 효과 설정(bold, italic 등)
  - `.boldSystemFont(of:)` : bold로 설정
  - `.preferredFont(forTextStyle:)` : System에서 미리 지정된 form(`UIFont.TextStyle`)으로 설정(`.body`, `.title1` 등)

- Placeholder

  - TextField에 text가 입력되지 않았을 때 회색으로 입력할 내용에 대한 guide 설정

    ```swift
    textField.placeholder = "placeholder"
    ```

- Border style

  - TextField의 기본 border style은 높이를 조절할 수 없음. 다른 style로 변경해야 가능.

    ```swift
    textField.borderStyle = .none
    textField.borderStyle = .bezel
    textField.borderStyle = .line
    textField.borderStyle = .roundedRect	// default
    ```

- Clear button

  - TextField의 text를 한 번에 지울 수 있는 버튼 제공

    ```swift
    textField.clearButtonMode = .always						// TextField에 항상 버튼을 띄움
    textField.clearButtonMode = .never						// 버튼을 띄우지 않음
    textField.clearButtonMode = .unlessEditing		// 입력하지 않는 동안에만 버튼을 띄움
    textField.clearButtonMode = .whileEditing			// 입력하는 동안에만 버튼을 띄움
    ```

- Secure Text Entry

  - Text를 `*`로 바꿔서 입력. Password 처럼 숨기려고 하는 text에 사용

    ```swift
    textField.isSecureTextEntry = true
    ```

- Adjust to fit

  - 길어지면 글자크기 작게만들어서 한번에 보이게 해줌. 최소 font size 조절

    ```swift
    // 입력된 글자가 textField의 width에 맞게 작아지도록 설정
    textField.adjustsFontSizeToFitWidth = true
    // 글자가 작아질 때 최소 글자 크기를 설정
    textField.minimumFontSize = 10
    ```

- Keyboard type

  - TextField의 용도에 따라 키보드를 다르게 보여줄 수 있음

  - [UIKeyboardType 종류](https://developer.apple.com/documentation/uikit/uikeyboardtype)

    ```swift
    textField.keyboardType = .URL
    ```

- Text Alignment

  - TextField에 입력되는 text의 위치

    ```swift
    textField.textAlignment = .center		// .left, .right, ...
    ```

## Text Field Event

- `UITextField`에서 처리하는 event 종류

  - `editingDidBegin` : text field 터치해서 입력을 시작할 때(focus 됐을 때) 호출
  - `editingChanged` : text field 값이 변경 될 때 마다 호출
  - `editingDidEnd` : text filed 입력이 종료될 때(focus 끝났을 때) 호출. 
  - `editingDidEndOnExit` : Return을 누르면 무조건 키보드를 내리고 editing을 끝냄, Primary action triggered도 끝나고 제일 마지막에 호출
  - `primaryActionTriggered` :`return` 키를 눌렀을 때 특별한 동작을 하거나 조건부로 동작할 경우 사용하게 됨. `didEndOnExit` method 다음에 호출.

  - 입력한 값이 잘못되었거나 할 때 키보드를 내리지 않게 하려면 did end on exit은 사용하지 않고 primary action triggered를 이용해서 검사할 수 있음

## Text Field Focus

- TextField가 editing할 수 있는 상태가 되면 **First Responder** 상태가 된 것임. 즉, textField가 First Responder가 되면 editing 상태가 되고 키보드가 나타나서 입력할 준비 상태가 됨
  - `becomeFirstResponder()` : TextField가 First Responder가 되어 event를 받을 수 있게 됨(editing 상태가 됨)
  - `resignFirstResopnder()` : TextField가 First Responder에서 해제되어 키보드가 내려가고 입력이 종료됨
  - TextField의 super view에서 `endEditing(Bool)`을 호출하여 모든 subview들의 first responder 상태를 해제할 수 있음