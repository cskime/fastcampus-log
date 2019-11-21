# App Life Cycle

## The Struct of an App

- iOS app의 구조 : MVC pattern
  - Model : 유저정보 등 각종 데이터 또는 데이터를 처리하는 로직
  - View : App에서 사용자가 보게 되는 화면 또는 구성하는 object들
  - Controller : View와 Model의 중간에서 데이터를 전달하는 매개체 역할

- 사용자 터치에 의한 app 반응
  - 사용자 터치 입력
  - iOS가 터치를 받아서 event queue에 전달
  - App의 event loop에서 발생한 이벤트를 처리

## App State

### Not Running

- 아직 실행되지 않았거나 완전히 종료된 상태
- `application(_:willfFinishLauncingWithOptions:)` : 앱이 최초 실행될 때 호출
- `application(_:didFinishLaunchingWithOptions:)` : 앱 실행 직후 화면에 보여지기 직전에 호출

### InActive

- 앱이 실행되었지만 이벤트를 받지 않는 상태
- 앱 실행 중 알림 등에 의해 화면이 덮여서 앱이 실질적으로 이벤트를 받지 못하는 상태

### Active

- 앱이 실제로 동작하고 있는 상태
- `applicationDidBecomeActive()` : 앱이 **Active** 상태로 전환된 직후 호출
- `applicationWillResignActive()` : 앱이 **Inactive** 상태로 전환되기 직전 호출

### Background

- 앱이 백그라운드에서 실제 동작하고 있는 상태
- 음악 앱에서 홈 화면으로 나가도 음악을 실행하는 등
- `applicationDidEnterBackground()` : 앱이 **Background** 상태로 전환된 직후 호출
- `applicationWillEnterBackground()` : 앱이 백그라운드 상태에서 **Active** 상태가 되기 직전에 호출. **화면에 보여지기 직전**

### Suspended

- 백그라운드 상태에서 활동을 멈춘 상태
- 다시 앱을 열 때 빠르게 실행하기 위해 메모리에는 남아았지만, 다른 작업으로 인해 메모리가 부족해지면 suspended 상태에 있는 앱을 iOS가 강제종료함
- `applicationWillTerminate()` : 앱이 종료되기 직전에 호출