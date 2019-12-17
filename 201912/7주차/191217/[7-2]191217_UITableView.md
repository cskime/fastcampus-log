# UITableView

- `UIScrollView`를 상속받아 **리스트 형태로 반복**되는 아이템을 보여주기 위한 view
- Plain Table Views
  - 하나 이상의 section을 가지며 section 당 하나 이상의 row를 가짐
  - Header View와 Footer View를 가지며 각각 Top, Bottom에 고정됨
  - Indexed List를 설정하여 빠르게 section 탐색 가능 (IndexPath)
- Grouped Table Views
  - 관련 Item들을 하나의 Group으로 묶음

## Content

- Dynamic Prototypes : Prototype cell을 만들고 identifier를 이용해 reusable queue에서 deque해서 사용
- Static Cells : 필요한 cell들을 미리 만들어 두고 그 상태로만 사용함

<br>

## UITableViewDataSource

- `UITableView`의 `dataSource` 프로퍼티에 `UITableViewDataSource` protocol을 구현한 객체를 전달
- `UITableView`에 표현될 **데이터를 제공**하기 위한 protocol. **필수 구현**

### Row

- `tableView(_:numberOfRowsInSection)` : 하나의 section에 row가 몇개 들어갈지 결정
- `tableView(_:cellForRowAt:)` : 화면에 나타날 cell을 반환. Cell이 나타날 때 마다 계속 호출됨
  - `indexPath.row` : 행(row) 번호. 0부터 cell 개수만큼 늘어남
  - `indexPath.section` : 열(section) 번호. 0부터 section 개수만큼 늘어남

### Section

- `numberOfSections(in:)` : Section의 개수 결정(default 1). Optional 구현 method.
- `tableView(_:titleForHeaderInSection:)` : Section title 설정

<br>

## UITableViewDelegate

- 사용자가  `UITableView`에서 하는 행동(Interaction)과 관련된 동작을 커스터마이징하는 protocol. **선택 구현**
- `UITableView`의 `delegate` 프로퍼티에 `UITableViewDelegate` protocol을 구현한 객체를 전달

### Methods

- `tableView(_:willDisplay:forRowAt)` : Cell이 화면에 나타날 때 호출
- `tableView(_:didEndDisplaying:forRowAt)` : Cell이 화면에서 사라질 때 호출
- `tableView(_:viewForHeaderInSection:)` : Section header에 custom viiew 설정
- `tableView(_:viewForFooterInSection:)` : Section footer에 custom viiew 설정
- `tableView(_:willSelectRowAt:)` : Cell 선택 시 `indexPath`를 반환해야 선택되고 `nil` 반환하면 선택불가

<br>

## UITableViewCell

### 재사용

- 한 번에 모든 cell을 메모리에 올려두면 메모리가 낭비됨

- **재사용 큐(Reusable Queue)**를 사용해서 실제로 화면에 나타나는 cell들만 queue에서 가져오고 화면 밖으로 나가면 queue에 반환. 다시 나타날 때는 틀만 재사용 큐에서 가져오고 data source를 이용해서 cell 안에 데이터를 넣음

- 시스템이 알아서 **재사용 큐에서 enqueue / dequeue 작업** 수행

- `dequeueReusableCell(withIdentifier:)`

  - 재사용 큐에서 identifier를 이용해 cell을 가져옴
  - Identifier에 해당하는 cell이 없을 수도 있으므로 optional type의 cell을 반환함
  - Identifier가 등록되어 있지 않다면 직접 cell을 만들어서 반환함. `tableView(_:cellForRowAt:) `에서 `reuseIdentifier`를 이용해서 생성한 `UITableViewCell`을 반환하면 `UITableView`가 해당 `identifier`로 cell을 관리할 수 있음. `register(_:forCellReuseIdentifier:)`의 역할

  ```swift
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    // 재사용 queue에서 identifier를 이용해서 cell을 가져옴
    if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "CellID") {
      cell = reusableCell
    } else {
      // 재사용 queue에 identifier가 등록되어 있지 않다면 새로 만든다
      cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
    }
    // 새로 만들어진 cell을 tableView가 identifier를 이용해 관리하게 됨.
    return cell
  }
  ```

- `dequeueReusableCell(withIdentifier:for:)`

  - 재사용 큐에서 identifier로 cell을 가져옴
  - 해당 `identifier`로 등록된 cell이 **반드시 있을 거라고 생각하고** 가져오는 것. 없다면 crash
  - 사용하기 전에 반드시 `identifier`를 `UITableView`에 **등록(`register`)**해야 함
    - `register(_:forCellReuseIdentifier:)` : `UITableView`에 `UITableViewCell` 타입의 cell을 `reuseIdentifier`를 이용해서 등록함

  ```swift
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Queue에서 "CellID" identifier를 갖는 cell을 가져옴
  	let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
  ```

### Life Cycle

- 화면에 나타나는 cell에 대해서만 `tableView(_:cellForRowAt:)`이 호출됨
- 스크롤하는 방향에 따라 다음 cell이 나타나면 이전 cell이 없어지게 됨. 위에서 없어지는 애들을 밑에서 새로 나오는 애들이 재사용해서 나타나는 것

### Style

- `default` : 기본 title만 있는 것
- `subtitle` : 기본 titler과 아래에 작은 subtitle을 가짐 
- `value 1` , `Right Detail`
- `value 2`, `Left Detail`
- `custom` : 정해진 형식 외에 다른 형식으로 cell을 구성할 때

### Structure

- `contentView` : 실제 content 올라가는 view. TableViewCell이 아니라 Content View에 올리는 것이 좋음
  - `textLabel`
  - `detailTextLabel`
  - `imageView`
- `accessoryView` : Cell 오른쪽에 특정 기능을 위한 영역
  - Disclosure Indicator
  - Detail Disclosure
  - Checkmark
  - Detail

<br>

## Custom UITableViewCell

- `init(style:reuseIdentifier:)` : Cell이 처음 생성될 때 호출. 첫 화면 등 queue에 들어간 cell이 없을 때
- `prepareForReuse()` : Cell이 dequeue되어 재사용될 때 호출

## Refresh

- `tableView.reloadData()` : `UITableView`를 data source부터 다시 그림. Data 변경 등의 이유로

- `UIRefreshControl` : Refresh animation view를 생성

  - `tintColor` : 색 지정

  - `addTarget` : Refresh할 때 어떤 동작을 할 것인지 설정. `.valueChanged` event를 받음

  - `attributedTitle` : Refreshing 밑에 text를 넣을 수 있음

    - `NSAttributedString` 타입으로 설정해야함
    - `NSAttributedString(string:attributes:)` 등 여러 가지 설정할 수 있음

    ```swift
    let attributedTitle = NSAttributedString(
      string: "Refreshing...",
      attributes: [
        .font: UIFont.systemFont(ofSize: 30),
        .kern: 5	// 자간?
      ]
    )
    refreshControl.attributedTitle = attributedTitle
    ```

- iOS11? 부터는 생성한 refresh control을 `tableView.refreshControl`에 넣으면 됨

- 작업이 다 끝났을 때 `endRefreshing()`을 호출하면 종료

## Other Attributes

- `tableView.rowHeight` : Cell 높이를 일괄적으로 설정
- `allowsMultipleSelection` : 여러 개의 cell을 선택할 수 있도록 설정
- `indexPathsForSelectedRows` : 현재 tableView에서 선택된 cell들의 `[indexPath]` 반환. `allowsMultipleSelection` 켜져있어야 함
- `tableView.cellForRow(at:)` : `indexPath`를 입력받아서 해당 `indexPath`에 있는 cell을 반환.