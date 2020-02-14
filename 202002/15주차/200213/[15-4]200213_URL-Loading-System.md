# URL Loading System

- URL과 상호작용하고 표준 인터넷 프로토콜을 통해 서버와 통신하기 위한 시스템
- `Foundation` Framework
- 프로토콜 지원 : FTP, HTTP, HTTPS, FILE, DATA, CUSTOM
- Class : `URLSession`, `URL`, `URLSessionTasks`, `URLRequest`, `URLResponse`

## URLSession

- 네트워크 데이터 전송과 관련된 클래스 그룹을 조정하는 객체. 네트워크용 API로 **비동기** 동작
- 간단한 요청은 `URLSession`에 URL만 전달해서 데이터를 가져오거나 파일 다운로드
- 데이터 업로드같은 복잡한 요청은 `URLRequest` 객체를 `URLSession`에 제공하여 `URLResponse`로 받음
- **URLSessionConfiguration**에 의해 `URLSession`의 동작이 결정된다

### Network API Lifecycle

- `URLSessionConfiguration`을 설정하고 `URLSession` 생성
- `URL` 또는 `URLRequest` 생성
- Task를 결정하고 **Completion Handler** 파라미터를 전달하거나 **delegate** method를 구현
  - Completion Handler를 사용하면 delegate는 호출되지 않음
  - 비교적 간단한 응답은 Completion Handler를 이용하고 세세한 처리가 필요할 때 delegate 이용
- `URLSession`을 통해 task 수행
- 작업 완료 후 completion handler 또는 delegate method가 호출되고 `URLResponse`를 처리한 뒤 종료

## URLSessionConfiguration

- `URLSession`이 데이터 upload/download를 수행할 때 사용되는 정책과 동작을 정의하는 환경설정 객체
- `URLSession`을 사용하기 위한 첫 번째 단계
- 시간제한, 캐싱정책. cellular 제한 여부, 연결 요구사항 등 `URLSession`에서 사용할 여러 유형의 정보 설정
- `URLSessionConfiguration`은 복사에 의한 값 전달이 일어나므로 새로운 설정을 위해서는 새로운 `URLSessionConfiguration` 객체를 생성해서 설정해야함
- `URLRequest` 설정과 `URLSessionConfiguration` 설정이 충돌할 경우 configuration 설정이 우선

### Shared Session(공유 세션)

- 별도의 configuration이나 delegate을 사용하지 않는 singleton으로 구현된 `URLSession` 객체

- 일반적으로 설정을 변경하지 않고 그대로 사용하며, customizing을 하려면 **Default Session** 사용

- 기본 설정만으로 충분한 간단한 요청에 적합함

  ```swift
  let shared = URLSession.shared
  ```

### Default Session(기본 세션)

- 기본 `URLSession`으로 설정을 따로 변경하지 않는다면 Shared Session과 비슷함. Delegate 사용 가능
- 디스크에 캐시와 쿠키를 저장하고 자격 증명은 user keychain에 저장

### Ephemeral Session(임시 세션)

 - 캐시, 쿠키, 자격 증명 등 어떤 정보도 디스크에 기록하지 않음
 - 메모리(RAM)에만 저장하기 때문에 앱이 세션을 무효화하면 세션 데이터가 제거됨
 - 앱이 종료되거나 메모리가 부족한 경우 시스템에 의해 메모리 데이터가 제거될 수 있음
 - 별도로 기록해야 할 내용을 직접 파일로 저장해야함

### Background Session

- 앱이 실행중이지 않은 상태에서도 데이터 전송이 가능하도록 설정
- 별도 프로세스에서 전송을 처리하도록 시스템에 전송 제어권을 전달함
- 앱을 종료하거나 재실행 할 때, 이전 종료 시점의 상태 및 세션 정보를 identifier를 통해 구분하여 재생성(시스템에 의해 종료될 때만)

## Session Task

- `URLSession`은 4가지 유형의 task를 지원
  - **Data** : 가장 많이 사용하게 됨. 데이터를 요청하고 JSON 등의 포맷으로 가져옴
  - Download, Upload, Stream
- `URLSession`에서 method 호출을 통해 `URLSessionTask` 객체를 생성하여 task 수행
- `URLSession`이 요청 작업이 종료되거나 실패할 때 까지 task에 대한 **강한 참조를 유지**함

### URLSessionDataTask

- Data를 주고받기 위한 task. Background 작업 미지원
- 

mimetype : 데이터 형태, 타입 정보(http, json, jpeg, ...)

task는 작업을 저장만 하는 것. resume()을 통해 실행시켜야만 작업이 실행되고 강한 참조를 유지하여 메모리상에 남아있을 수 있음

