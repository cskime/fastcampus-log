# User Defaults

- iOS에서 데이터를 **파일에 저장**하기 위해 사용하는 클래스 중 하나
- 내부적으로 `plist` 파일에 저장함
- **메모리에 저장**하면 앱이 종료되면 저장되어 있던 정보가 삭제됨
- **파일로 저장**해 두면 **앱이 삭제되기 전 까지** 저장된 데이터가 계속 남아있음
- 파일은 메모리에 비해 속도가 느리지만 비교적 영구적으로 데이터를 저장할 수 있음
- 일반적으로 singleton으로 사용됨

```swift
let userDefaults = UserDefaults.standard

userDefaults.set(10, forKey:"Ten")


```

## Methods

- 값 설정
  - `set(_:forKey:)` : Key를 이용해서 어떤 값을 저장함
- 값 가져오기
  - `integer(forKey:)` : Key를 이용해서 어떤 integer 값을 가져옴
  - `double(forKey:)` : Key를 이용해서 어떤 double 값을 가져옴
  - `bool(forKey:)` : Key를 이용해서 어떤 bool 값을 가져옴
  - `object(forKey:)` : 기본으로 제공되는 자료형 같은 타입 외에 내가 만든 타입을 가져올 때 사용. 어떤 타입인지 알 수 없으므로 `Any?` 타입으로 반환되기 때문에 **캐스팅**해서 사용해야 함
    - Custom type은 파일에 저장하기 위해 인코딩 작업이 필요함. `Codable` 등을 사용해서 별도의 인코딩 후 저장
    - iOS에서 제공하는 타입들 중 내부적으로 인코딩이 제공된다면 바로 사용할 수 있다
    - `UIImage`는 `Data`로 직접 인코딩한 다음 저장해야한다.
  - `dictionaryRepresentation()` : 데이터를 dictionary 형태로 보여줌. 아무 값을 넣지 않았어도 기본값들이 들어있음
    - `dictionaryRepresentation().keys` : Key들만 가져옴
    - `dictionaryRepresentation().values` : Value들만 가져옴
- 값 가져오기에 실패하면 `object(forKey:)`에서는 `nil`을 반환, 나머지는 `0`이나 `false`같은 기본값을 반환함.