# UIScrollView

- Content Size
  - 현재 보여지는 뷰에 상관없이 스크롤 뷰가 표현할 수 있는 전체 컨텐츠 크기
  - `UIScrollView`를 넘어가는 크기로 content size가 정해지고, 안보이는 영역을 스크롤로 볼 수 있음

## Attributes

- `frame` : 화면상에 잡힌 `UIScrollView`의 `frame`. 바뀌지 않음
- `contentSize` : Content의 크기. Zoom에 따라 달라짐
- `bounds`, `contentOffset`
  - Content가 이동하는 위치에 따라 서로 동일한 `origin` 값을 가짐. 서로 동일한 역할을 하는 `CGPoint` 값
  - `setContentOffset(_:animated:)`같은 Method를 사용하기 위해 `bounds`보다 `contentOffset`을 사용하는게 좋다. `bounds`는 개념적으로 동일하다는 것
- `alwaysBounceVertical` : 세로 방향으로 스크롤 할 수 없을 때 bounce 효과를 줌.
- `alwaysBounceHorizontal` : 가로 방향으로 스크롤 할 수 없을 때 bounce 효과를 줌.

## Usage in Storyboard

- Storyboard에서 `UIScrollView`에 Auto Layout을 추가할 때 content layout guide 체크를 풀어야함
- `UIScrollView`에서 Auto Layout 추가할 때는 `UIView`의 위치를 지정해 줘도 스크롤 하면서 view의 위치나 모양이 달라질 수 있으므로, **위치 anchor가 정해졌더라도 크기 anchor를 반드시 지정해야 한다.**

### Storyboard에서 UIScrollView의 contentView 전체를 확인하는 방법

- ViewController의 [Size Inspector] - [Simulated Size]를 `Freedom`으로 설정하면 storyboard에서 ViewController의 크기를 변경할 수 있다. 크기를 변경해도 실제 실행했을 때는 ViewController에 나타나는 화면이 나타남.
- 화면에 나타날 떄 `multiplier`가 0.5인 `constraint`를 설정해서 화면에는 모두 나오게 하고, `Remove at Build Time`을 설정하여 실제로는 적용되지 않게 함
- `multiplier`가 1.0인 `constraint`를 만들고 `priority`를 `High`로 낮춰주면 실제로 실행되었을 때는 `multiplier`가 1.0인 `constraint`로 적용됨

## Zoom

- `UIScrollView`에서 zoom 할 때 최대/최소 zoom scale을 설정해야한다. 기본값은 (max, min) = (1, 1)

  ```swift
  scrollView.minimumZoomScale = 0.5		// 최소 zoom scale
  scrollView.maximumZoomScale = 2			// 최대 zoom scale
  ```

- `UIScrollView`의 content를 zoom in / zoom out

  ```swift
  scrollView.zoomScale = 1										// Zoom scroll view
  scrollView.setZoomScale(1, animated: true)	// Zoom with Animation
  scrollView.zoom(to: rect, animated: true)		// Zoom to specific area. Auto scale
  ```

- Zoom할 때는 `UIScrollViewDelegate`에서 zoom할 view를 직접 설정해 줘야 함

  ```swift
  extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
     	return specificView 
    }
  }
  ```

## Move Content

- `contentOffset`을 설정하여 `UIScrollView` 안에 content를 이동시킬 수 있음

- `bounds`와 같은 역할이지만 `contentOffset` 사용을 권장

  ```swift
  let newOffset = CGPoint(x: 100, y: 100)
  scrollView.contentOffset = newOffset		// Set Offset
  scrollView.bounds = newOffset						// Set Offset using bounds 
  scrollView.setContentOffset(newOffset, animated: true)	// Set Offset with animation
  ```

## UIScrollViewDelegate

- `viewForZooming(in:)` : `UIScrollView`의 content들 중에 zoom할 view를 반환

- `scrollViewDidScroll(_:)` : `UIScrollView`에서 스크롤하는 동안 연속적으로 호출됨

  ```swift
  extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { return view }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {  }
  }
  ```

  