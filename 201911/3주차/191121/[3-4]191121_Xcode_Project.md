# Xcode Project

## AppDelegate와 SceneDelegate

- 앱의 실행부터 종료될 때 까지의 life cycle 동안 앱의 특정 state에 실행될 `application` method들을 구현
- Xcode 11 이상 버전부터 **`AppDelegate`**와 **`SceneDelegate`**가 함께 생성됨
- `AppDelegate`로부터 UI 관련 작업을 `SceneDelegate`로 분리
- iOS 13 이상은 UI관련 작업에 `SceneDelegate`를 이용하고 이전 버전은 모두 `AppDelegate`에서 작업 처리

### SceneDelegate를 사용하지 않을 때

- `SceneDelegate.swift` 파일 삭제
- `AppDelegate` 클래스에서 `UIScene`과 관련된 method들을 삭제
- `info.plist`에서 `Application Scene Manifest` 키를 삭제
- `AppDelegate` 클래스에서 `var window: UIWindow?` 프로퍼티 추가

### SceneDelegate를 사용할 때

- iOS 13 이상과 iOS 12 이하 버전을 구분해서 사용해야함

- `SceneDelegate` 클래스를 iOS 13 이상에서만 사용하도록 annotation

  ```swift
  @available (iOS 13, *)
  class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    ...
  }
  ```

- `AppDelegate` 클래스에서 `UIScene`을 사용하는 method에 IOS 13 이상에서만 사용하도록 annotation

  ```swift
  @UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {
  
      // MARK: UISceneSession Lifecycle
  		@available (iOS 13, *)
      func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // statement
          return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
      }
    
  		@available (iOS 13, *)
      func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  			// statement
      }
  }
  ```

## UIApplicationMain

- App은 `main` 함수에서부터 시작됨

- `AppDelegate`에 붙은 `@UIApplicationMain` annotation이 `UIApplication` 함수의 호출을 대신하고 있음

- `@UIApplicationMain` annotation 대신 `main.swift`를 직접 구현할 수도 있음

  ```swift
  // main.swift
  
  UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    	.bindMemory(to: UnsafeMutablePointer<Intt8>.self,
                 	capacity: Int(CommandLine.argc)),
    nil,
    NSStringFromClass(AppDelegate.self)
  )
  ```

- 이렇게 만들어진 `main.swift` 파일을 제외하고, 다른 모든 파일에서 `class`라는 단위를 벗어나서 **top level**에 전역 함수 등을 호출하는 것은 불가능.

  ```swift
  // main.swift
  
  print("1")
  print("2")
  
  UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    	.bindMemory(to: UnsafeMutablePointer<Intt8>.self,
                 	capacity: Int(CommandLine.argc)),
    nil,
    NSStringFromClass(AppDelegate.self)
  )
  
  /////////////////////////////////////////////////////////
  
  // Top level에서 사용할 수 없음
  // print("Print outside of Class")
  class ViewController: UIViewController {
    ...
  }
  ```

  