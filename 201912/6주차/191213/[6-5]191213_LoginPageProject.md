# Login Page 만들기

## Description

- AutoLayout을 이용하여 주어진 Login Page 구현
- UserDefaults를 이용하여 회원가입 후 여러 계정의 로그인 기능, 한번 로그인한 뒤 자동 로그인 기능 구현
- 로그인에 실패하거나 회원 가입 시 이메일이 중복되는 경우, textField가 빨간색으로 표시되었다가 원상복귀되어 사용자의 재입력을 유도하도록 구현
- UITextField에 입력 시 글자 수 제한(4~16자)
- UITextField 선택 시 키보드가 입력필드를 가리지 않도록 textField가 위로 올라가도록 구현. UIView animation 사용

## Implementation

### Class Design

- 객체 지향 패러다임에 맞게 클래스를 설계하여 유지보수가 용이하도록 하고 재사용성을 높임

- 클래스 설계 시 MVC패턴을 고려하여 Controller와 View를 구분

- **LoginViewController**

  - LogoView
    - ImageView : FastCampus Image
    - UIStackView : 3 red dots using `UIView`
  - FormContainerView
    - ImageView : Left Image
    - TextField : Input TextField
    - Underline : Use `UIView` height 1
    - `UITextField`에 입력된 text를 이용하기 위한 method
      - `canSignIn()` : 로그인 시도할 때 입력된 text와 UserDefaults 데이터를 비교
      - `canSignUp()` : 회원가입 시도할 때 입력된 text와 UserDefaults 데이터를 비교
      - `fetch()` : `emailTextField`와 `passwordTextField`에 입력된 두 text를 튜플로 반환하기 위함(`(email: String, password: String)`)
  - SignContainerView
    - Sign In Button : `SignButton(type: .SignIn)`
    - Sign Up Button : `SignButton(type: .SignUp)`
    - `SignButton`의 action method는 delegate pattern을 이용해서 해결. 
  - FormContainerView와 SignContainerView는 각각 `UIButton`, `UITextField`의 delegate를 위해 `set~Delegate(_:)` method를 사용함

- **MainViewController**

  - Login에 성공하면 메인 화면으로 이동하도록 함. 메인 화면에는 로그인한 사용자의 email이 표시됨

  - `logOutButton`

    - 로그인 후 `logOutButton`을 이용해서 `LoginViewController`로 돌아감

    - 한번 로그인하면 `UserDefaults`에 로그인 여부가 저장되어 자동 로그인됨. 이 때는 `window`의 `rootViewController`가 `MainViewController`부터 시작됨

      ```swift
      if UserDefaults.standard.bool(forKey: UserInfoKey.isLogined) {
        window.rootViewController = MainViewController()
      } else {
        window.rootViewController = LoginViewController()
      }
      window.makeKeyAndVisible()
      ```

    - 자동 로그인된 상황에서 되돌아가려면 `dismiss(animated:)`를 사용하지 않고 `AppDelegate`의 `window.rootViewController`에  `LoginViewController`를 설정함

      ```swift
      if presentingViewController == nil {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = LoginViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        window.makeKeyAndVisible()
      }
      ```

- **SignUpViewController**

  - 회원가입을 위한 화면을 별도로 생성
  - LoginViewController에서 사용했던 FormContainerView를 입력 폼으로 사용함
  - 아무것도 하지 않고 돌아가기 위한 `UIButton` 생성.
  - 회원 가입을 위한 `SignButton(type: .SignUp)` 생성. UserDefaults에 이미 동일한 아이디가 있다면 가입할 수 없음

## AutoLayout

- ContainerView의 auto layout 설정 시, 내부 view들의 content size를 이용해서 container view의 크기가 자동으로 조정됨. Positiion 관련 constraint만 설정하면 된다

  ```swift
  class ContainerView {
  	 private func setConstraints() {
      	NSLayoutConstraints.activate([
  					contentView.topAnchor.constraints(equalTo: self.topAnchor),
  	        contentView.leading.constraints(equalTo: self.leading),
          	contentView.trailing.constraints(equalTo: self.trailing),
          	contentView.bottomAnchor.constraints(equalTo: self.bottomAnchor),
          // contentView의 bottomAnchor를 self(containerView)의 bottomAnchor에 걸어서
          // constraint를 생성하면 self의 크기는 자동으로 contentView에 맞춰짐
        ])
     }
  }
  ```

## Delegate Pattern

- `SignButton`의 action method에서 실행될 내용을 **Delegate Pattern**을 이용하여 설정할 수 있도록 함

  ```swift
  // SignUp, SignIn, SingOut 등 만드는 곳에 따라 다르게 구현할 수 있도록
  // optional로 설정하여 필요할 때만 구현 가능하도록 함
  @objc protocol SignButtonDelegate: class {
      @objc optional func signUpTouched()
      @objc optional func signInTouched()
      @objc optional func signOutTouched()
  }
  
  class SignButton: UIButton {
  
      weak var delegate: SignButtonDelegate?
      
    	//...
    	
      enum SignType {
          case SignIn
          case SignUp
          case SignOut
      }
  	  private var signType: SignType = .SignIn
    
    	//...
    
  		@objc func signTouched(_ sender: SignButton) {
          switch self.signType {
          case .SignIn:
              delegate?.signInTouched?()
          case .SignUp:
              delegate?.signUpTouched?()
          case .SignOut:
              delegate?.signOutTouched?()
          }
      }
  }
  
  // LoginViewController에서는 SignInButton과 SignUpButton을 묶는 SignContainerView를 사용함
  // LoginViewController에서 SignButton까지 callback method를 전달하기 위해 delegate 사용
  
  class ViewController: UIViewController {
    	// ...
    	
   		private func setupUI() {
        signView.setButtonDelegate(self)
        // SignContainerView에 있는 두 SignButton에 모두 delegate를 설정
      }
  }
  
  extension ViewController: SignButtonDelegate {
      func signInTouched() {
          if inputForm.canSignIn(), let userInfo = inputForm.fetch() {
              let mainVC = MainViewController()
              mainVC.modalPresentationStyle = .fullScreen
              
              UserDefaults.standard.set(true, forKey: UserInfoKey.isLogined)
              UserDefaults.standard.set(userInfo.email, forKey: UserInfoKey.loginedEmail)
              UserDefaults.standard.set(userInfo.password, forKey: UserInfoKey.loginedPassword)
              
              present(mainVC, animated: true)
          }
      }
      
      func signUpTouched() {
          let signUpVC = SignUpViewController()
          signUpVC.modalPresentationStyle = .fullScreen
          present(signUpVC, animated: true)
      }
  }
  ```

- `LoginViewController` -> `FormContainerView` -> `FormTextField` -> `UITextField`까지 `UITextFieldDelegate`을 위한 delegate 전달을 위해 `FormContainerView`와 `FormTextField`에서 `setTextFieldDelegate(_:)` method를 사용

  ```swift
  class LoginViewController: UIViewController {
    private func setupUI() {
      formContaimerView.setTextFieldDelegate(self)
    }
  }
  
  class FormContainerView: UIView {
    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
      emailTextField.setTextFieldDelegate(delegate)
  		passwordTextField.setTextFieldDelegate(delegate)
    }
  }
  
  class FormTextField: UIView {
    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
      textField.delegate = delegate		// LoginViewController의 참조 전달
    }
  }
  ```

  