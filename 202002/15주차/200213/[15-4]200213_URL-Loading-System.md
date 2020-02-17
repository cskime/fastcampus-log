# URL Loading System

- URL과 상호작용하고 표준 인터넷 프로토콜을 통해 서버와 통신하기 위한 시스템
- `Foundation` Framework
- 프로토콜 지원 : FTP, HTTP, HTTPS, FILE, DATA, CUSTOM
- Class : `URLSession`, `URL`, `URLSessionTasks`, `URLRequest`, `URLResponse`

## URL

- URL은 ASCII code로만 encoding할 수 있으므로 한글 같은 unicode 문자는 사용할 수 없음

  ```swift
  let urlStringE = "https://www.naver.com/search.naver?.query=swift"
  print(URL(string: urlStringE) ?? "Nil")		// some URL
  
  let urlStringK = "https://www.naver.com/search.naver?.query=한글"
  print(URL(string: urlStringE) ?? "Nil")		// Nil
  ```

- ASCII code로 표현할 수 없는 문자들에 대해 **Percent Encoding** 필요

  ```swift
  // Query에 대해 percent encoding : .urlQueryAllowed
  let queryEncodedStr = urlStringK
  	.adddingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
  print(URL(string: urlStringE) ?? "Nil")		// some URL
  ```

- `color-#708090`의 경우 URL의 `fragment` 키워드인 `#`와 중복되므로, URL로 사용할 때는 percent encoding을 통해 `%23`으로 변환하고 실제로 값을 사용할 때는 percent encoding을 제거해야함

  ```swift
  let originalString = "https://example.com/#color-#708090"
  
  // Fragment에 대해 percent encoding : .urlFragmentAllowed
  let encodedString = originalString
  	.addingPercentEncoding(withAllowedCharacterrs: .urlFragmentAllowed)!
  
  // Encoding 제거
  encodedString.removingPercentEncoding
  ```

## URLComponents

- URL의 각 구성요소들을 설정해서 새로운 `URL` 생성 가능

  ```swift
  var components = URLComponents()
  components.scheme = "http"
  components.user = "username"
  components.password = "password"
  components.host = "www.example.com"
  components.port = 80
  components.path = "/index.html"    // path는 /로 시작해야 함
  components.query = "key1=value1&key2=value2"	// query 직접 입력
  components.queryItems = [											// query item 등록
  	.init(name: "key1", value: "value1"),
  	.init(name: "key2", value: "value2")
  ]
  components.fragment = "myFragment"
  let url = components.url
  ```

- 기존 `URL`로부터 생성하여 URL의 각 구성요소를 parsing 가능

  ```swift
  if let components = URLComponents(url: url, reesolvingAgainstBaseURL: true) {
    print(comp.scheme ?? "")
    print(comp.user ?? "")
    print(comp.password ?? "")
    print(comp.host ?? "")
    print(comp.port ?? "")
    print(comp.path ?? "")
    print(comp.query ?? "")
    print(comp.fragment ?? "")  
    
    // 기존 URL에서 특정 component 변경 가능
    comp?.queryItems = [
      URLQueryItem(name: "name", value: "tory"),
      URLQueryItem(name: "age", value: "5"),
    ]
  }
  ```

## URLSession

- 네트워크 데이터 전송과 관련된 클래스 그룹을 조정하는 객체. 네트워크용 API로 **비동기** 동작
- 간단한 요청은 `URLSession`에 **URL만 전달**해서 데이터를 가져오거나 파일 다운로드
- 데이터 업로드같은 복잡한 요청은 **`URLRequest`** 객체를 `URLSession`에 제공하여 `URLResponse`로 받음

### Network API Lifecycle

1. `URLSessionConfiguration`을 설정하고 `URLSession` 생성
2. `URL` 또는 `URLRequest` 생성
3. Task를 결정하고 **Completion Handler** 파라미터를 전달하거나 **delegate** method를 구현
  - Completion Handler를 사용하면 delegate는 호출되지 않음
  - 비교적 간단한 응답은 Completion Handler를 이용하고 세세한 처리가 필요할 때 delegate 이용
4. `URLSession`을 통해 task 수행
5. 작업 완료 후 completion handler 또는 delegate method가 호출되고 `URLResponse`를 처리한 뒤 종료

## URLSessionConfiguration

- **URLSessionConfiguration**에 의해 `URLSession`의 동작을 결정함. `URLSession`을 사용하기 위한 첫 번째 단계
- `URLSession`이 데이터 upload/download를 수행할 때 사용되는 정책과 동작을 정의하는 환경설정 객체
- 시간제한, 캐싱정책. cellular 제한 여부, 연결 요구사항 등 `URLSession`에서 사용할 여러 유형의 정보 설정
- `URLSessionConfiguration`은 복사에 의한 값 전달이 일어나므로 새로운 설정을 위해서는 새로운 `URLSessionConfiguration` 객체를 생성해서 설정해야함
- `URLRequest` 설정과 `URLSessionConfiguration` 설정이 충돌할 경우 **configuration 설정이 우선**

### Shared Session(공유 세션)

- 별도의 configuration이나 delegate을 사용하지 않는 singleton으로 구현된 `URLSession` 객체

- 일반적으로 설정을 변경하지 않고 그대로 사용하며, customizing을 하려면 **Default Session** 사용

- 기본 설정만으로 충분한 간단한 요청에 적합함

  ```swift
  let session = URLSession.shared
  ```

### Default Session(기본 세션)

- 기본 `URLSession`으로 설정을 따로 변경하지 않는다면 Shared Session과 비슷함. Delegate 사용 가능

- 디스크에 캐시와 쿠키를 저장하고 자격 증명은 user keychain에 저장

  ```swift
  let defaultConfig = URLSessionConfiguration.default
  defaultConfig.allowsCellularAccess = false	// default true. WIFI만 사용가능
  defaultConfig.httpMaximumConnectionPerHost = 5 	// default 4 몇명까지?
  defaultConfig.timeoutIntervalForRequest = 20	// default 60(1 minute)
  defaultConfig.requestCachePolicy = .reloadIgnoringLocalCachedata	// default .useProtocolCachePolicy
  // Netwalk 불안정 등 연결에 실패했을 경우 바로 실패를 반환할 것인지, 
  // 안정될 때를 기다릴 것인지 설정
  defaultConfig.waitsForConnectivity = true	// default false. 
  
  let session = URLSession(configuration: defaultConfig)
  ```

### Ephemeral Session(임시 세션)

 - 캐시, 쿠키, 자격 증명 등 어떤 정보도 디스크에 기록하지 않음

 - 메모리(RAM)에만 저장하기 때문에 앱이 세션을 무효화하면 세션 데이터가 제거됨

 - 앱이 종료되거나 메모리가 부족한 경우 시스템에 의해 메모리 데이터가 제거될 수 있음

 - 별도로 기록해야 할 내용을 직접 파일로 저장해야함

   ```swift
   let ephemeral = URLSessionConfiguration.ephemeral
   let session = URLSession(configuration: ephemeral)
   ```

### Background Session

- 앱이 실행중이지 않은 상태에서도 데이터 전송이 가능하도록 설정

- 별도 프로세스에서 전송을 처리하도록 시스템에 전송 제어권을 전달함

- 앱을 종료하거나 재실행 할 때, 이전 종료 시점의 상태 및 세션 정보를 identifier를 통해 구분하여 재생성(시스템에 의해 종료될 때만)

  ```swift
  let background = URLSessionConfiguration.background(withIdentifier: "com.cskim.example.configBackground")
  let session = URLSession(configuration: background)
  ```

## Session Task

- `URLSession`은 4가지 유형의 task(`URLSessionTask`)를 지원
  - **`URLSessionDataTask`** : 가장 많이 사용하게 됨. 데이터를 요청하고 JSON 등의 포맷으로 가져옴
  - `URLSessionUploadTask` : 파일 형태로 upload하기 위한 task. Background Upload 지원
  - `URLSessionDownloadTask` : 파일을 바로 disk로 다운받기 위한 task. Background 지원
  - `URLSessionSteramTask` : **TCP/IP 연결**을 통한 지속적인 데이터 교환을 위한 task
- `URLSession`에서 method 호출을 통해 `URLSessionTask` 객체를 생성하여 task 수행.
- Task 생성 후 **`resume()`** method 호출을 통해 task에 저장된 작업을 실행함
- `URLSession`이 요청 작업이 종료되거나 실패할 때 까지 task에 대한 **강한 참조를 유지**함

### Request Get

- `dataTask(with:completion:)`에 URL만 전달하면 기본 request method가 `GET`으로 설정됨

  ```swift
  let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
  let url = URL(string: todoEndpoint)!
  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard error == nil else { return print(error!.localizedDescription) }
    guard
      let response = response as? HTTPURLResponse,
      (200..<300).contains(response.statusCode),
      response.mimeType == "application/json"		// JSON 데이터
    else { return }
    guard let data = data else { return print("Invalid Data") }                                                
  	
  	// Use data..
  }
  task.resume()
  ```

### Request Post

- 새로운 데이터를 추가할 때 `POST` method로 변경해야함

- `URLRequest`를 생성하여 `httpMethod`와 `httpBody`를 설정하고 `URLRequest`로 task를 생성

  ```swift
  let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
  let url = URL(string: todoEndpoint)
  let newTodo: [String: Any] = [
    "title": "My Todo",
    "userID": "20"
  ]
  let jsonTodo = try! JSONSerialization.data(withJSONObject: newTodo)
  
  // URLRequest 생성
  var newRequest = URLRequest(url: url)
  urlRequest.httpMethod = "POST"	// method 변경
  urlRequest.httpBody = jsonTodo	// 추가할 데이터 전달
  
  // New Task
  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in 
  	// Error Handling...
  	guard let data = data else { return }
  	
  	// Use data..
  }
  task.resume()
  ```

### Request Delete

- 데이터 삭제 요청을 보낼 때 method를 `DELETE`로 변경해야 함

- 데이터 삭제에는 새로운 데이터가 필요없으므로 `httpBody`를 설정하지 않아도 됨

  ```swift
  // URL Setting...
  ...
  
  // New Request
  var newRequest = URLRequest(url: url)
  newRequest.httpMethod = "DELETE"
  
  // New Task
  URLSession.shared.dataTask(with: url) { (data, response, error) in
  	// Error Handling...
  	guard let data = data else { return }
  	
  	// Use data..
  }.resume()
  ```

## URLCache

- URL 요청을 `CachedURLResponse` 객체에 매핑하여 응답에 대한 캐싱을 구현하기 위한 객체

- `shared`를 통한 singleton 객체를 사용하거나 직접 생성 가능

  ```swift
  // Memory : 16KB (16 * 1024 = 16_384)
  // Disk : 256MB (256 * 1024 = 268_435_456)
  let myCache = URLCache(
    memoryCapacity: 16_384, diskCapacity: 268_435_456
  )
  myCache.diskCapacity
  myCache.currentDiskUsage
  myCache.memoryCapacity
  myCache.currentMemoryUsage
  myCache.removeAllCachedResponse()	// Cache 삭제
  
  // Default Session Configuration에 추가
  defaultConfig.urlCache = myCache					// Custom Cache
  defaultConfig.urlCache = URLCache.shared	// Shared Cache
  ```

- `SessionConfigureation` 또는 `URLRequest`에서 4 종류의 캐시 정책(Cache Policies)에 따라 각각 다르게 작업

  - `reloadIgnoringLocalCacheData` : 캐시 파일을 무시하고 항상 원본 소스에 접근

  - `returnCacheDataDontLoad` : 오프라인 모드와 유사함. 캐시 파일이 존재할 때만 데이터 반환

  - `returnCacheDataElseLoad` : 캐시 파일을 우선. 없을 경우 원본 소스에 접근

  - `useProtocolCachePolicy` : 각 프로토콜별 정책에 따름

    ```swift
    defaultConfig.requestCachePolicy = .reloadIgnoringLocalCachedata	// default .useProtocolCachePolicy
    ```

## Helper Class

- **`URLRequest`**

  - URL 요청에 대한 추가 메타데이터 제공을 위한 helper class
  - 프로토콜에 독립적인 방식으로 URL 및 모든 프로토콜 관련 속성을 캡슐화한 객체
  - 일부 프로토콜에 대한 속성을 지원함.(HTTP의 경우 requestBody, headers 설정/반환 메서드를 추가)

- **`URLResponse`**

  - URL 응답에 대한 추가 메타데이터 제공을 위한 helper class

  - 서버 응답 데이터 중 메타데이터의 데이터들만 캡슐화한 객체

    - 메타 데이터 = MIME + 예상 컨텐츠 길이 + text encoding + responseURL
    - mimeType : 데이터 형태, 타입 정보(http, json, jpeg, ...)

  - 프로토콜별 하위 클래스는 추가 메타데이터를 제공할 수 있음

    ```swift
    guard let response = response as? HTTPURLResponse else { return }
    response.header			// Header
    response.statusCode	// URL 응답 코드
    ```