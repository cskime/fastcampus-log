# UIStackView

## Storyboard

- **Axis** : Item이 정렬되는 방향
  - 가로 : `.horizontal`
  - 세로 : `.vertical`
- **Alignment** : Axis와 직교되는 방향의 정렬방법 설정
  - **Horizontal**
    - Fill : 위아래로 딱 맞게 채움
    - Center : 원래 크기를 유지하며 Vertical Center로 정렬
    - Top, Bottom : 원래 크기를 유지하며 해당 방향으로 정렬(상, 하)
    - FirstBaseLine, LastBaseLine : 처음 / 끝의 text baseline을 기준으로 정렬
  - **Vertical**
    - Fill : 좌우로 딱 맞게 채움
    - Center : 원래 크기를 유지하며 Horizontal Center로 정렬
    - Leading, Trailing : 원래 크기를 유지하며 해당 방향으로 정렬(좌, 우)
- **Distribution** : Axis와 같은 방향의 정렬방법 설정
  - Fill : ICS와 CHCR을 고려하여 우선순위에 따라 너비가 결정됨. 별도로 width, height layout이 정해졌다면 해당 size로 설정
  - Fill Equally : **ICS와 CHCR을 고려하지 않고** 모든 item view의 크기를 똑같이 설정
  - Fill Proportionally : Item view들의 크기를 비율로 계산해서 전체 stack view 크기 안에 크기를 나누어 할당
  - Equal Spacing : ICS와 CHCR을 고려하여 원래 사이즈를 유지하면서 view 사이의 간격(spacing)을 똑같이 만드는 것
  - Equal Centering : ICS와 CHCR을 고려하여 view의 center 사이의 간격을 똑같이 만드는 것
- **Spacing** : Axis 방향으로 item 사이의 간격 설정. 가로(`leading`, `trailing`) 또는 세로(`top`, `bottom`)에 해당하는 constraint가 자동으로 잡힘
- UIStackView의 크기는 **내부 content들의 크기의 합으로** 지정됨
  - Axis 방향 : Subview size + Total Spacing
  - 직교방향(Perepndicular) : 가장 큰 subview의 size

## Programmatically

```swift
// UIStackView 생성
let stackView = UIStackView()
stackView.axis = .vertical
stackView.distribution = .fillEqually
stackView.alignment = .fill
stackView.spacing = 8
view.addSubview(stackView)

// Auto Layout. 
// 크기는 내부 content size가 stack view에 의해 자동으로 constraint가 잡혀있으므로 
// UIStackView는 위치에 대한 constraint만 잡아도 됨
stackView.translatesAutorersizingMaskIntoConstraints = false
stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

// Item view 추가
let someLabel = UILabel()
someLabel.text = "someLabel"
stackView.addArrangedSubview(someLabel)
```

- UIStackView`도 `UIView`를 상속받은 일종의 view이므로, `UIView`가 갖는 속성을 동일하게 가짐

|   구분   |          UIView          |         UIStackView         |
| :------: | :----------------------: | :-------------------------: |
|   추가   |      `addSubview:`       |    `addArrangedSubview:`    |
|   삽입   | `insertSubview:atIndex:` | `insertArrangedSubview:at:` |
|   제거   |  `removeFromSuperview`   |  `removeArrangedSubview:`   |
| Subviews |        `subviews`        |     `arrangedSubviews`      |

- `UIStackView`에서 `addArrangedSubview`를 사용하면 `addSubview`도 함께 사용하게 됨. `subviews`와 `arrangedSubviews`에 모두 추가됨
- `UIStackView`에서 `removeArrangedSubview:`를 사용하면 `arrangedSubviews`에서는 제거되지만 `subviews`에는 남아있음. View 자체가 사라진 것이 아니라 `UIStackView`에서 보이지 않을 뿐