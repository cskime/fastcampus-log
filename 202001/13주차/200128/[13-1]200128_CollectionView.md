# UICollectionView

- `UICollectionView`는 `UITableView`같이 `dataSource`와 `delegate`을 이용해 데이터를 collection 형식으로 화면에 표시하는 object
- `UITableView`와 달리 `UICollectionViewLayout` object를 통해 `UICollectionView`에서 item(`UICollectionViewCell`)의 위치 및 크기를 설정해야함

## Content Management

- DataSource와 delegate로 content를 관리하며, layout object를 이용해 cell의 위치 및 크기를 설정함

## Presentation

### Cell

- `UICollectionViewCell` object. Collection View의 item 하나를 표현
- **Section**단위의 그룹 안에서 표현
- `IndexPath`의 `section`, `row`로 표현, Item 자체를 `item`으로 표현
- 재사용(`dequeueReusableCell(withReusableIdentifier:for:)`)
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
  - `itemSize` : `UICollectionViewCell`의 크기 지정
  - `headerReferenceSize` : `UICollectionView`의 footer size 지정
  - `footerReferenceSize` : `UICollectionView`의 footer size 지정
  - `minimumLineSpacing` : Scrolling direction 방향으로 item(cell) 사이의 너비 지정(**Cell Spacing**)
  - `minimumInteritemSpacing` : Scrolling direction의 수직 방향으로 item(cell) 사이의 너비 지정(**Line Spacing**)
  - `sectionInset` : Content의 `UICollectionView` 안쪽에서의 너비. `UIEdgeInsets`(**Section Inset**)
  - `scrollDirection` : `UICollectionView`의 스크롤 방향 설정.
- **Scrolling Direction과 수직 방향으로** item(cell)이 생성되고 데이터가 쌓여 나감
- 관련 object : `UICollectionViewFlowLayout`, `UICollectionViewDelegateFlowLayout`

### Custom Layout

- Flow layout 외에 직접 만들어 사용하는 layout
- 관련 object : `UICollectionViewLayout`, `UICollectionViewLayoutAttributes`, `UICollectionViewUpdateItem`

## UICollectionViewDataSource

- `numberOfSections(in:)` : Collection view의 section 개수 설정
- `collectionView(_:numberOfItemsInSection:)` : Collection view에서 section당 item 개수 설정
- `collectionView(_:cellForItemAt:)` : `UICollectionViewCell`의 content에 data를 전달하기 위한 method
  - `dequeueReusableCell(withReuseIdentifier:for:)` : `UICollectionViewCell`을 재사용하기 위한 method.
  - `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` : Collection view에서 Header / Footer 역할을 하는 `UICollectionReusableView`를 재사용하기 위한 method

## UICollectionViewDelegate

### Observe displaying items

- `collectionView(_:willDisplay:forItemAt:)`
- `collectionView(_:didEndDisplaying:forItemAt:)`

### Observe touching items

- `collectionView(_:shouldSelectItemAt:)`
- `collectionView(_:didSelectItemAt:)`
- `collectionView(_:shouldHighlightItemAt:)`
- `collectionView(_:didHighlightItemAt:)`

## UICollectionViewDelegateFlowLayout

- `UICollectionViewFlowLayout`에서 설정할 수 있는 속성들을 `indexPath`에 따라 **동적으로 설정**할 수 있음
- `UICollectionViewDelegate` 프로토콜이 함께 채택되어 있다.

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

## UICollectionViewCell

- ContentView 위에 CustomView가 올라오게 됨.
- `allowsSelection` 속성이 `true`일 때 `isSelected`, `isHighlighted` 속성을 사용할 수 있음
  - `isHighlighted` : Cell을 터치하고 있는 동안 `true`
  - `isSelected` : Cell을 터치한 뒤 손을 떼면 `true`
  - Touch -> `isHighlighted = true` -> Touch Up -> `isSelected = true` - > touch end
- `UITableViewCell`과 달리, 기본적인 `titleLabel`이나 `imageView`가 제공되지 않음

## Tips

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

  

