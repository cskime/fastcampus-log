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

### Editing

- `tableView(_:commit:forRowAt)` : `commit editingStyle` 파라미터를 이용해서 edit mode에서 할 작업을 설정함
  - `editingStyle` : Edit mode에서 선택한 동작이 `.delete`인지 `.insert`인지 정보

<br>

## UITableViewDelegate

- 사용자가  `UITableView`에서 하는 행동(Interaction)과 관련된 동작을 커스터마이징하는 protocol. **선택 구현**
- `UITableView`의 `delegate` 프로퍼티에 `UITableViewDelegate` protocol을 구현한 객체를 전달

### Cell Life Cycle

- `tableView(_:willDisplay:forRowAt:)` : Cell이 화면에 나타나기 직전에 호출됨. ViewController 단에서 cell의 frame을 기준으로 크기를 잡을 때, `cell.frame`이 완전하게 설정된 순간
- `tableView(_:didEndDisplaying:forRowAt:)` : Cell이 화면에 나타난 후 호출됨

### Row & Section

- `tableView(_:viewForHeaderInSection:)` : Section header에 custom viiew 설정
- `tableView(_:viewForFooterInSection:)` : Section footer에 custom viiew 설정
- `tableView(_:willSelectRowAt:)` : Cell 선택 시 `indexPath`를 반환해야 선택되고 `nil` 반환하면 선택불가

### Editing

- `tableView(_:canEditRowAt:)` : 각 `indexPath`의 정보를 받아서 cell마다 edit할 수 있는지 없는지 결정. `false`를 반환하면 빨간색 edit 버튼도 안나옴
- `talbeView(_:editingStyleForRowAt:)` : Cell마다 editing style 설정
- `tableView(_:trailingSwipeActionsConfigurationForRowAt:)` : Cell을 오른쪽(trailing)에서 당길 때 오른쪽에서 나타나는 action button 설정
- `talbeView(_:leadingSwipeActionsConfigurationForRowAt:)` : Cell을 왼쪽(leading)에서 당길 때 왼쪽에서 나타나는 action button 설정
- `tableView(_:editActionsForRowAt:)` : iOS 8 ~ iOS 10까지 사용되던 것. `trailingSwipeActionsConfiguration` method와 같은 기능. 현재 Deprecated

<br>

## UITableViewCell

### Reusable Cell

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

### Structure

- `contentView` : 실제 content가 올라가는 view. CustomCell을 사용할 때 content들을 `contentView.addSubview(label)`처럼 **Content View에 올리는** 것이 좋음
  - `textLabel`, `detailTextLabel` : 기본으로 들어가 있는 `UILabel`. Style에 따라 위치가 달라짐
  - `imageView` : Left Detail에서는 사용되지 않음
- `accessoryView` : Cell 오른쪽에 특정 기능을 위한 영역

### Style

- Custom(`custom`) : 정해진 형식 외에 다른 형식으로 cell을 구성할 때
- Basic(`default`) : 기본 `titleLabel`만 있는 것. `register`에 등록할 때 기본 설정되는 스타일
- Subtitle(`subtitle`) : 기본 `titleLabel`과 아래에 작은 `detailTextLabel`을 가짐 
- Right Detail(`value1`) : 기본 `titleLabel`과 cell 오른쪽 끝에 `detailTextLabel`을 가짐
- Left Detail(`value2`) : 기본 `titleLabel`과 `detailTextLabel`가 cell 왼쪽에 작게 들어있음
- Cell이 기본으로 갖고 있는 `imageView`는 cell 가장 왼쪽에 위치함. 단, Left Detail 스타일에서는 `imageView`가 빠짐

### Accessory(`accessoryType`)

- Disclosure Indicator : `>` 기호가 나타남
- Detail Disclosure : 정보 확인 버튼과 `>` 기호가 함께 나타남
- Checkmark : 체크표시
- Detail : 정보 확인 버튼이 나타남

<br>

## CustomCell

- `init(style:reuseIdentifier:)` : Cell이 처음 생성될 때 호출
  - `dequeueReusableCell(withIdentifier:)`를 이용해서 cell을 가져오려고 할 때, 화면에 처음 나타나는 등 아직 queue에 들어간 cell이 없으면 `init`이 호출되며 직접 cell을 생성함
- `prepareForReuse()` : 스크롤하면서 cell이 화면에서 사라지고 재사용 큐에 들어가면, 그 이후부터는 화면에 나타나는 cell이 재사용 큐에서 dequeue되면서 `prepareForReuse()` method 호출

### Content 설정

- `UITableViewCell`을 상속받는 `CustomCell`에서 content를 올릴 때는 cell 자신이 아니라 `contentView`에 올려야 함

  ```swift
  class CustomCell: UITableViewCell {
    let myLabel = UILable()
   	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      // 커스텀 뷰를 올릴 때는 contentView 위에 추가
      contentView.addSubview(myLabel)
      myLabel.textColor = .yellow
      myLabel.backgroundColor = .black
    }
  }
  ```

- `CustomCell`을 포함한 모든 `CustomView`에서는 `init` 단계에서 아직 `frame`이 형성되기 전이기 때문에 `self.frame`을 사용할 수 없음. `frame`을 이용해서 layout을 설정할 때는 `layoutSubviews()` 안에서 `self.frame`을 이용해서 동적으로 위치, 크기를 설정해줘야함. `self.frame`이 아니라 고정값으로 layout을 설정하는 것은 괜찮다

  ```swift
  class CustomCell: UITableViewCell {
    let myLabel = UILable()
   	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      ...
      
      // init에서는 고정값을 이용한 크기설정은 가능
      // 동적으로 변할 수 없으므로 좋은 방법이 아님
      myLabel.frame = CGRect(x: 100, y: 15, width: 100, height: 30)
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()
      
      // self.frame을 이용해서 동적으로 content 크기를 설정하려면 여기서 해야함
      myLabel.frame = CGRect(
        x: self.frame.width - 12, y: 15,
        width: 100, height: self.frame.height - 30
      )
    }
  }
  ```

- 하지만, `frame`이 아니라 AutoLayout으로 layout을 잡을 때는 `init`에서 잡아도 괜찮다. AutoLayout은 layout을 잡는 시점이 `init`이 아니라 더 뒤에서 실제로 잡히기 때문임. `init` 또는 `updateConstraints()`에서 설정할 수 있다

  ```swift
  class CustomCell: UITableViewCell {
    let myLabel = UILable()
   	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      // AutoLayout을 이용할 땐 init에서도 설정 가능
      myLabel.translateAutoresizingMaskIntoConstraint = false
      myLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
    }
    
    override func updateConstraints() {
      super.updateConstraints()
      
      // AutoLayout이 실제로 잡히는 시점에서 설정해줘도 됨
  		myLabel.translateAutoresizingMaskIntoConstraint = false
      myLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
    }
  }
  ```

<br>

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

- 작업이 다 끝났을 때 `endRefreshing()`을 호출하면 종료

<br>

## Editing

- TableView에 있는 cell을 지우거나 삭제하거나 동작
- Delete한 뒤 tableView를 구성하는 dataset에서도 해당 data를 삭제하는 로직이 필요함

### TableView

- `tableView.isEditing` : 현재 tableView가 edit mode인지 확인

- `tableView.setEditing(_:animated:)` : TableView edit mode 전환

- `tableView.deleteRows(at:with:)` : `at`에 넣는 `[IndexPath]`들에 있는 cell을 삭제

  - `with`에 넣은 `animation`에 해당하는 방향으로 삭제됨

  - **TableView를 구성하는 데이터를 먼저 삭제한 뒤에 cell을 삭제해야 함**

  - Dataset에서 삭제되는 index와 tableView에서 삭제되는 cell의 `indexPath.row`가 맞아야 할 것

    ```swift
    data.remove(at: data.firstIndex(of: data[indexPath.row])!)
    tableView.deleteRows(at: [indexPath], with: .automatic)
    ```

- `tableView.insertRows(at:with:)` : `at`에 넣는 `[IndexPath]`들의 위치에 새로운 cell을 삽입

  - `with`에 넣은 `animation`에 해당하는 방법으로 추가

  - **TableView를 구성하는 dataset에 값을 먼저 추가한 뒤 cell을 추가해야 함**

  - Dataset에서 추가되는 index와 tableView에서 추가될 cell의 `indexPath.row`가 맞아야 할 것

    ```swift
    data.insert((1...50).randomElement(), at: indexPath.row)
    tableView.insertRows(at: [indexPath], with: .automatic)
    ```

### DataSource

- `tableView(_:commit:forRowAt)` : 각 edit mode마다 수행할 동작 설정가능

### Delegate

- `tableView(_:canEditRowAt:)` : Edit 기능 설정. 왼쪽 edit button을 사용할지 말지 결정
- `tableView(_:editingStyleForRowAt)` : Row의 editing style 설정 가능. Default는 `delete`
- `tableView(_:trailingSwipeActionsConfigurationForRowAt:)` 
  - **iOS 11 이상부터** 지원되는 기능. Cell을 **오른쪽에서 당길 때** action 설정
  - 이 method를 구현하면 기본값을 덮어쓰기 때문에 기본 delete swipe는 사용할 수 없음. 직접 구현해야함
  - `UIContextualAction(style:title:handler)`을 이용해서 오른쪽(trailing) 방향에서 swipe할 때 나타나는 버튼 및 `action` 설정
    - `style`
      - `normal` : 회색 기본 버튼
      - `destructive` : 위험한 동작. 빨간색 버튼
      - `action.background`로 색상 설정 가능
    - `handler` : Action이 실행될 때 동작 구현
  - `UIContextualAction` 객체들을 담아서 `UISwipeActionsConfiguration(actions:)`로 configuration 객체 생성
    - Swipe를 끝까지 했을 때, configuration 생성 시 전달한 `actions` 배열에 가장 앞에 추가된 것이 실행됨
    - configuration을 별도로 변수로받아서 설정할 수도 있음. `performsFirstActionWithFullSwipe` 속성을 `false`로 하면 끝까지 잡아당길 때 action을 끌 수 있다
- `tableView(_:leadingSwipeActionsConfigurationForRowAt:)` : 왼쪽(leading)에서 당길 때
- `tableView(_:editActionsForRowAt:)`
  - **iOS 8 ~ iOS 10**까지 사용하던 기능.
  - `tableView(_:trailingSwipeActionsConfigurationForRowAt:)`과 동일한 기능
  - `UISwipeActionConfiguration`을 이용하라고 deprecated된 상태
  - `UITableViewRowAction`을 이용해서 구현함
  - 왼쪽에서 나타나도록 하는 기능은 없기 때문에 직접 구현해야했음

## Other Attributes

- Cell Row Height

  - `tableView.rowHeight` : Cell 높이를 **일괄적으로** 설정. 실제로 보여지는 cell의 크기

    - `UITableView.automaticDimension` : Content들의 크기에 따라 cell의 크기를 유동적으로 조정함. 기본값

  - `tableView.estimatedRowHeight` : 완전한 cell의 높이를 잡기 전에 `estimatedRowHeight`을 이용해서 **대략적인 높이**를 잡고 그때 나타날 cell들을 미리 만들어 둠. **실제로 나타나는 높이는 `rowHeight`.** 

    - 화면에 나타나지 않은 cell인데도 `cellForRowAt`과 `willDisplay` method가 호출되었다가 `didEndDisplaying` method가 호출됨
    - 우선 `estimatedRowHeight` 기준으로 화면에 보이는 cell을 만들었다가 실제로 화면에 나타나지 않은 cell은 다시 재사용 큐로 보내서 `didEndDisplaying`이 호출된 것

    ```swift
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    ```

  - `tableView(_:heightForRowAt)` delegate method로 **각각의 cell 크기**를 다르게 설정 가능

    ```swift
    extension TableViewController: UITableViewDelegate {
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    		if indexPath % 4 == 0 {
          return 120		// 첫 번째 cell 높이는 120
        } else {
          return 50			// 나머지 cell의 높이는 50
        }
      }
    }
    ```

- `allowsMultipleSelection` : 여러 개의 cell을 선택할 수 있도록 설정

- `indexPathsForSelectedRows` : 현재 tableView에서 선택된 cell들의 `[indexPath]` 반환. `allowsMultipleSelection` 켜져있어야 함

- `tableView.cellForRow(at:)` : `indexPath`를 입력받아서 해당 `indexPath`에 있는 cell을 반환.