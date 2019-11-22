# View Content Mode

## Scailing

- `scaleToFill` : 비율 상관하지 않고 화면에 딱 맞게 채움
- `scaleAspectFit` : 비율을 유지하면서 이미지가 잘리지 않도록 화면에 딱 맞게 채움
- `scaleAspectFill` : 비율을 유지하고 화면에 꽉 채움. 이미지가 잘릴 수 있음

## Redrawing

- `redraw` : View의 크기가 변경될 때마다 연관 컨텐츠를 항상 다시 그리게 하는 것
- `setNeedsDisplay()` : View가 다음 drawing cycle에서 content를 다시 그리도록 요청
- `draw(_:)` : 크기를 변경할 때 마다 다시 그려야 하므로 성능상 좋지 않음

## Positioning

- View에서 content 위치를 정함
- `center`
- `top`, `botttom`, `left`, `right`
- `topLeft`, `topRight`, `bottomLeft`, `bottomRight`