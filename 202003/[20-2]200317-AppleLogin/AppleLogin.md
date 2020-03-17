# Sign in With Apple

- Apple ID를 사용한 로그인을 더 쉽게 다룰 수 있는 기능 제공
- 수집하는 데이터는 이름, 이메일로 제한. **비공개 이메일 릴레이 기능**을 사용하면 이메일 주소를 공개하지 않고도 이메일 받을 수 있다
- 타사 로그인 서비스를 사용하는 앱에서는 반드시 Apple ID 로그인을 제공해야함
- Sign in With Apple은 iOS 13.0부터 사용가능
- 이전 버전에서는 기존 방식(Sign in With Apple JS) 사용. 다른 플랫폼에서 애플 계정으로 로그인하기 위한 방법

### Apple Login

- 사진 URL 없음
- 신규 계정을 생성하면 이름, 이메일 전달
- 이메일 숨기기를 선택하면 원래 이메일을 비공개하여 제공할 수 있음
- 앱/웹 개발자만 원래 메일 주소로 메일을 보낼 수 있음
- 사용자 이름, 이메일 주소는 최초 로그인 시에만 계정 설정을 위해 제공하기 때문에 별도로 저장해 둬야 한다

### Closed Email

- 애플 로그인 시 사용자는 이메일 공개/비공개 여부를 선택 가능
- 비공개 선택 시 생성되는 릴레이 이메일 주소를 통해 이메일을 보내면 원래 메일 주소로 전달됨.

## HIG Authentication

- 일관된 사용자 경험을 위해 모든 플랫폼에서 애플 로그인 기능의 제공을 고려해야 한다(애플, 안드로이드, 웹 등)
- 로그인 화면은 정말 필요할 때만 나오게 만들어야 함. 처음부터 필요하지도 않은데 로그인 화면이 나타나지 않게
- 서비스에 가입하는 방법과 인증했을 때 이점을 설명해야 함
- 이메일이라면 이메일 관련 키보드를 보여주는 등 적절한 키보드 타입을 제공해야 함
- Passcode 용어를 사용하지 않아야 함.(iOS 언락과 Apple Pay 인증에 사용되기 때문)
- 개발 시 `AuthenticationServices` Framework 사용

### 권장사항

- 계정 설정 시 꼭 필요한 데이터만 요청하여 데이터 요청을 최소화
- 데이터 요청 사유 및 수신 데이터를 명확히 표시하여 애플 로그인을 신뢰할 수 있도록 함
- 애플 로그인은 비밀번호가 필요 없으므로 요청하지 말 것
- 릴레이 이메일 주소를 받으면 다시 개인 이메일 주소를 물어보지 말아야 함
- 사용자가 개인 릴레이 주소를 확인할 수 있게 해야 함
- 구매 정보는 이메일로 저장하지 않고 주문번호, 전화번호 등으로 식별할 것
- 로그인 후 수집된 데이터를 활용한 화면을 보여주어 데이터 요청 사유를 알 수 있도록 할 것

## Apple ID Button

- 애플 로그인 버튼이 한번에 나타나야함

- 제공하는 버튼을 그대로 사용하는 것을 권장

- 버튼 가이드

  | Minimum Width | Minimum Height | Minimum Margin              |
  | ------------- | -------------- | --------------------------- |
  | 140pt         | 30pt           | 1/10 of the button's height |

## System Button

- ASAuthorizationAppleIDButton Type
  - `signIn`
  - `signUp` : iOS 13.2부터 지원
  - `continue`
  - `default` : `singIn`

- ASAuthorizationAppleIDButton Style
  - White : 
  - WhiteOutline : iOS, macOS, Web에서만 사용 가능
  - Black

- ASAuthorizationAppleIDButton CornerRadius
  - Default : 6
  - Minimum : 0
  - Maximum : button height / 2. 캡슐 모양

## Custom Button

- 반드시 제공하는 리소스를 받아서 사용해야 함

  > https://developer.apple.com/design/resources/

- PNG, SVG, PDF 포맷 사용 가능
- 로고 + Title 또는 로고만 있는 버튼으로 사용 가능
- 받은 리소스를 변형하지 않고 그대로 사용해야 함

## 사용자 식별자(User ID)

- 고유하고 안정적인 문자열로 구성
- Apple ID를 사용해서 로그인하는 같은 개발 팀의 모든 앱에서 동일한 식별자 사용
- 데이터베이스에 사용자의 기본 키와 함께 저장. 사용자 구분을 위해 이메일 주소 대신 사용자 식별자를 사용하는 것을 권장함

## Usage

- `AuthenticationServices` Framework을 import해서 사용 가능

### 버튼 생성

- `ASAuthoriizationAppleIDButton(authorizationButtonType:authorizationButtonStyle:)`

- `layer`가 아닌 자체 제공하는`cornerRadius` 속성을 사용해서 테두리 조절

  ```swift
  let appleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
      appleIDButton.cornerRadius = appleIDButton.frame.height / 2
      appleIDButton.addTarget(self, action: #selector(didTapAppleIDButton(_:)), for: .touchUpInside)
  ```

### 로그인 화면

- `ASAuthorizationAppleIDProvider`를 통해 `ASAuthorizationAppleIDRequest` 생성

  ```swift
  let idRequest = ASAuthorizationAppleIDProvider().createRequest()
  idRequest.requestedScopes = [.email, .fullName]   // 요청할 데이터 명시해야함
  ```

- `ASAuthorizationController`로 로그인 화면을 띄움

  ```swift
  let controller = ASAuthorizationController(authorizationRequests: [idRequest])
  contrroller.delegate = self
  contrroller.presentationContextProvider = self
  contrroller.performRequests()  // 실제 요청하는 부분
  ```

### 로그인 성공/실패 처리

- `ASAuthorrizationControllerDelegate`에서 로그인 성공/실패 처리

- 로그인 성공 : `ASAuthorizationAppleIdCredential`을 통해 user data 처리

  - `user` : 고유하게 생성된 user id
  - `fullName` : User name. Family, Given
  - `email` : User Email. 사용자의 공개/비공개에 따라 다른 email을 받는다
  - `identityToken` : 로그인한 user의 정보(user info, 시간, 암호화 정보 등)를 모아둔 데이터. Server에 넘겨주면 서버에서 token을 parsing하고 apple에 추가 인증을 포함한 작업을 할 수 있다
  - `realUserStatus` : 실제 사용자가 로그인한 것인지 여부에 따라 추가 인증을 거치거나 로그인을 거부하는 등 추가 작업을 수행할 수 있음

  ```swift
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    print("로그인 성공")
    guard let idCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
      let idToken = idCredential.identityToken,
      let tokenString = String(data: idToken, encoding: .utf8) else { return }
  
    print(tokenString)  // backend(server)와 작업할 때 사용하게 됨. 서버에 tokenString 저장
  
    let userID = idCredential.user
    let familyName = idCredential.fullName?.familyName ?? ""
    let givenName = idCredential.fullName?.givenName ?? ""
    let email = idCredential.email ?? ""
  
    let user = User(id: userID, familyName: familyName, givenName: givenName, email: email)
    print(user)
  
    // 한번 로그인하면 이후부터는 정보를 제공하지 않음. 받은 정보를 일단 로컬에 저장해 둬야 한다.
    // 서버에 저장해서 사용자가 앱을 지우거나 다른 기기로 교체했을 때에도 사용 가능하게
    if let encodedData = try? JSONEncoder().encode(user) {
      UserDefaults.standard.set(encodedData, forKey: "AppIDData")
      print(encodedData)
    }
  
    switch idCredential.realUserStatus {
    case .likelyReal:
      print("아마도 실제 사용자일 가능성이 높음")
    case .unknown:
      print("실제 사용자인지 봇인지 확실하지 않음")   // 추가 확인 단계 등을 거칠 수 있음
    case .unsupported:
      print("iOS가 아님. Sign In With Apple은 iOS에서만 지원")
    default:
      break
    }
  
    let vc = presentingViewController as! ViewController
    vc.user = user
    dismiss(animated: true)
  }
  ```

- 로그인 실패

  ```swift
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("로그인 실패")
    guard let error = error as? ASAuthorizationError else { return }
  
    // Error Handling
    switch error.code {
    case .unknown:
      print("Unknown")
    case .canceled:
      print("Cacneled")
    case .invalidResponse:
      print("InvalidResponse")
    case .notHandled:
      print("Not Handled")
    case .failed:
      print("Failed")
    @unknown default:
      print("Default")
    }
  }
  ```

### 로그인 화면 표시

- Apple Login 화면이 완전하게 나타나려면 device 화면에 맞춰야 하기 때문에 일반적인 view에는 설정할 수 없고 반드시 `UIWindow`를 반환해야함

  ```swift
  extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
      return self.view.window!
    }
  }
  ```

  