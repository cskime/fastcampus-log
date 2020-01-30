# UICollectionView

- `UICollectionView`는 `UITableView`같이 `dataSource`와 `delegate`을 이용해 데이터를 collection 형식으로 화면에 표시하는 object
- `UITableView`와 달리 `UICollectionViewLayout` object를 통해 `UICollectionView`에서 item(`UICollectionViewCell`)의 위치 및 크기를 설정해야함

## Content Management

- DataSource와 delegate로 content를 관리하며, layout object를 이용해 cell의 위치 및 크기를 설정함

## Presentation

### Cell

- `UICollectionViewCell` object. Collection View의 item 하나를 표현
- **Section**단위의 그룹 안에서 표현
- `IndexPath`의 `section`, `row`로 표현, Item 자체를 `item`으로 표현
- 재사용
- **`Layout` object의 주 용도**가 cell(item)들을 collection view 위에 배치하는 것

### Supplementary Views

- `UICollectionReusableView` object
- Collection view의 **header / footer view** 표현. Section마다 존재
- 높이를 0으로 설정하면 생성되지 않지만, 생성한다면 반드시 구현해야함

### Decoration Views

- Collection view의 배경을 꾸미는 데 사용되는 view. **Layout object**를 통해 정의

## Layout

- `UICollectionView`에서 cell 및 decoration views들의 크기 및 위치를 설정하는 object. 화면에 나타내는 방법과 관련된 속성을 설정할 수 있음

- `UICollectionView`를 생성할 때 반드시 layout object를 설정해야 함

  ```swift
  let layout = UICollectionViewFlowLayout()
  let collectionView = UICollectionView(frame: view.frame, layout: layout)
  ```

### Flow Layout

- 기본으로 제공되는 layout
- **Scrolling Direction과 수직 방향으로** item(cell)이 생성되고 데이터가 쌓여 나감
- 관련 object : `UICollectionViewFlowLayout`, `UICollectionViewDelegateFlowLayout`

#### Scroll Direction

- `scrollDirection` : `UICollectionView`의 스크롤 방향 설정.

#### Congifure Item

- `itemSize` : `UICollectionViewCell`의 크기 지정
- `minimumLineSpacing` : Scrolling direction 방향으로 item(cell) 사이의 너비 지정(**Cell Spacing**)
- `minimumInteritemSpacing` : Scrolling direction의 수직 방향으로 item(cell) 사이의 너비 지정(**Line Spacing**)
- `sectionInset` : Content의 `UICollectionView` 안쪽에서의 너비. `UIEdgeInsets`(**Section Inset**)

#### Congifure Supplementary View(Header/Footer)

- `headerReferenceSize` : `UICollectionView`의 footer size 지정. 기본값 `(0, 0)`
- `footerReferenceSize` : `UICollectionView`의 footer size 지정. 기본값 `(0, 0)`
  - 세로 스크롤에서는 `width`가 collection view의 `width`에 따라 정해지므로 **`height`만 적용됨**
  - 가로 스크롤에서는 `height`가 collection view의 `height`에 따라 정해지므로 **`width`만 적용됨**
- `sectionHeadersPinToVisibleBounds` : 스크롤할 때 header view가 상단에 고정
- `sectionFootersPinToVisibleBounds` : 스크롤할 때 footer view가 하단에 고정

### Custom Layout

- Flow layout 외에 직접 만들어 사용하는 layout
- 관련 object : `UICollectionViewLayout`, `UICollectionViewLayoutAttributes`, `UICollectionViewUpdateItem`

## UICollectionViewCell

- ContentView 위에 CustomView가 올라가는 구조

  - BackgroundView > SelectedBackgroundView > ContentView > CustomView

- `UITableViewCell`과 달리, 기본적인 `titleLabel`이나 `imageView`가 제공되지 않음

- `UITableView`같이 **재사용 큐**를 이용한 cell의 재사용

  - `register(_:forCellWithReuseIdentifier:)` : Code 사용 시 collection view에서 재사용할 cell 등록
  - `dequeueReusableCell(withReuseIdentifier:for:)` : `UICollectionViewCell`을 재사용하기 위한 method.

- `allowsSelection` 속성이 `true`일 때 `isSelected`, `isHighlighted` 속성을 사용할 수 있음

  - `isHighlighted` : Cell을 터치하고 있는 동안 `true`, 손을 떼면 `false`
  - `isSelected`
    - Cell을 터치한 뒤 손을 떼면 `true`
    - 단일 selection : Select된 cell을 다시 touch하거나 다른 cell을 select하면 `false`
    - 다중 selection : Select된 cell을 다시 touch하면 `false`
  - Touch -> `isHighlighted = true` -> Touch Up -> `isSelected = true` - > touch end

- `UICollectionView`에서 cell을 재사용 할 때, **select된 `indexPath`의 `isSelected` 속성을 내부적으로 기억**하고 있다. Cell이 선택되었을 때 동작을 `isSelected` 속성을 `override`해서 구현하면 선택된 cell의 `indexPath`를 기억하기 때문에 cell을 재사용해도 섞이지 않는다.

  ```swift
  override var isSelected: Bool {
  	didSet {
    	print("isSelected :", isSelected)
      self.checkImageView.isHidden = !self.isSelected
      self.blindView.backgroundColor = self.isSelected ? 
      																 UIColor.black.withAlphaComponent(0.4) : 
      																 .clear
  	}
  }
  ```

## UICollectionReusableView

- `register(_:forSupplementaryViewOfKind:withReuseIdentifier)` : Code로 사용 시 collection view에서 재사용할 supplementary view 등록
  - Header : `UICollectionView.elementKindSectionHeader`로 등록
  - Footer : `UICollectionView.elementKindSectionFooter`로 등록
- `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` : Collection view에서 **Header / Footer** 역할을 하는 `UICollectionReusableView`를 재사용하기 위한 method

## UICollectionViewDataSource

### Configure Cell

- `numberOfSections(in:)` : Collection view의 section 개수 설정
- `collectionView(_:numberOfItemsInSection:)` : Collection view에서 section당 item 개수 설정
- `collectionView(_:cellForItemAt:)` : `UICollectionViewCell`의 content에 data를 전달하기 위한 method

### Configure Supplementary View

- `collectionView(_:viewForSupplementaryElementOfKind:at:)` : Collection view에서 header, footer view 역할을 하는 supplementary view 반환. Supplementary view의 content에 data를 전달하기 위한 method

### Interactive Movement

- `collectionView(_:canMoveItemAt:)` : `UICollectionView`에서 `beginInteractiveMovementForItem()`을 호출하면 실행되는 method. `true`를 반환해야 interactive movement 기능 사용 가능
- `collectionView(_:moveItemAt:to:)` : `endInteractiveMovement()`를 호출하면 실행되는 method. Item을 끌어 움직이다가 놓는 순간 호출됨

## UICollectionViewDelegate

### Obseving Display Cell

- `collectionView(_:willDisplay:forItemAt:)` : Cell이 화면에 나타나기 직전 호출
- `collectionView(_:didEndDisplaying:forItemAt:)` : Cell이 화면에 완전히 나타난 뒤 호출

### Observing Select Items

- `collectionView(_:shouldSelectItemAt:)` : Collection view의 item에 `isSelected` 결정
- `collectionView(_:didSelectItemAt:)` : Collection view의 item이 select 되었을 때 호출
- `collectionView(_:didDeselectItemAt:)` : Collection view의 item이 deselect 되었을 때 호출

### Observing Highlight Items

- `collectionView(_:shouldHighlightItemAt:)` : Collection view의 item에 `isHighlighted` 결정
- `collectionView(_:didHighlightItemAt:)` : Collection view의 item이 highlight 되었을 때 호출
- `collectionView(_:didUnhighlightItemAt:)` : Collection view의 item이 unhighlight 되었을 때 호출

### Observing Multiple Selection

- `collectionView(_:shouldBeginMultipleSelectionInteractionAt:)` : Collection view에서 dragging하는 multiple selection을 허용할 것인지 결정
- `collectionView(_:didBeginMultipleSelectionInteractionAt:)` : Collection view에서 dragging하는 multiple selection을 시작할 때 호출
- `collectionViewDidEndMultipleSelectionInteraction(_:)` : Collection view에서 dragging하는 multiple selection을 끝냈을 때 호출

## UICollectionViewDelegateFlowLayout

- `UICollectionViewFlowLayout`에서 설정할 수 있는 속성들을 `indexPath`에 따라 **동적으로 설정**할 수 있음
- `UICollectionViewDelegate` 프로토콜이 함께 채택되어 있다.

```swift
protocol UICollectionViewDelegateFlowLayout: UICollectionViewDelegate {
  // IndexPath에 따라 item size를 동적으로 설정
  optional func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize
  
  // Section에 따라 section inset을 동적으로 설정
  optional func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int) -> UIEdgeInsets
  
  // Section에 따라 최소 line spacing / item spacing을 동적으로 설정
  optional func collectionView(_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat
  
  optional func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
  
  // Section에 따라 header / footer size를 동적으로 설정
  optional func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection At section: Int) -> CGFloat
  
  optional func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int) -> CGFloat
}
```

## Tips and Tricks

### CaseIterable

- `enum`에 `CaseIterable` protocol을 채택하면 `allCases` 속성으로 모든 case들에 대한 collection을 얻음

  ```swift
  enum CompassDirection: CaseIterable {
      case north, south, east, west
  }
  
  print("There are \(CompassDirection.allCases.count) directions.")
  // Prints "There are 4 directions."
  let caseList = CompassDirection.allCases
                                 .map({ "\($0)" })
                                 .joined(separator: ", ")
  // caseList == "north, south, east, west"
  ```


### FloatingPointRoundingRule

- `Double`, `Float`, `CGFloat` 등 소수점을 갖는 값에 대해 `rule`에 따라 소수점 처리

- `round()` : 값 자체를 변경, `rounded()` : 변경된 값을 변경

  - `awayFromZero`, `.up` : 소수점 자리수를 올림 연산
  - `towardZero`, `.down` : 소수점 자리수를 버림 연산
  - `toNearestOrEven`, `toNearestOrAwayFromZero` : 소수점 반올림

  ```swift
  let underHalf: CGFloat = 6.1
  let overHalf: CGFloat = 6.5
  
  underHalf.rounded(.up)	// 7.0
  overHalf.rounded(.up)		// 7.0
  underHalf.rounded(.awayFromZero)	// 7.0
  overHalf.rounded(.awayFromZero)		// 7.0
  
  underHalf.rounded(.down)	// 6.0
  overHalf.rounded(.down)		// 6.0
  underHalf.rounded(.towardZero)	// 6.0
  overHalf.rounded(.towardZero)		// 6.0
  
  underHalf.rounded(.toNearestOrEven)		// 6.0
  overHalf.rounded(.toNearestOrEven)		// 7.0
  underHalf.rounded(.toNearestOrAwayFromZero)		// 6.0
  overHalf.rounded(.toNearestOrAwayFromZero)		// 7.0
  ```

### Blur Effect

- `UIVisualEffectView` 객체를 subview로 추가함으로써 view에 특정 효과를 줄 수 있다

- `UIBlurEffect` 객체를 `UIVisualEffectView`에 적용시켜서 view에 blur 효과를 줄 수 있다.

  ```swift
  let effectView = UIVisualEffectView()
  effectView.effect = UIBlurEffect(style: .dark)
  view.addSubview(effectView)
  ```

  

