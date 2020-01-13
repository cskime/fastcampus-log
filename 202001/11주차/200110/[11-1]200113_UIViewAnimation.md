# UIView Animation

## UIImageView Animation

- `UIImageView`에서 여러 개의 `UIImage`에 대한 animation 설정
- `imageView.animationImages` : Animation에 사용할 image들 추가. 추가된 Image들이 바뀌는 animation
- `imageView.startAnimating` : `animationImages`에 추가된 `UIImage`들로 animation
- `imageView.stopAnimating` : Animation 종료
- `imageView.animationDuration` : `animationImages`에 추가된 `UIImage`들로 animation을 수행할 때 한 바퀴 돌리는데 걸리는 시간 설정
- `imageView.animationRepeatCount` : `animationImages`들을 이용한 animation을 몇 번 반복할지 설정

## UIView Animation

### Animate

- `UIView.animate()` 를 사용해서 애니메이션 적용

  - `withDuration` : Animation이 실행되는 전체 시간
  - `delay` : Animation이 실행되는 시간. 0 이상 값을 주면 실행 시간이 늦춰짐
  - `animations` : Animation 적용
  - `completion` : Animation이 끝난 뒤 호출. 끝까지 성공적으로 실행되었다면 매개변수가 `true`. 중간에 다른 화면으로 넘어가는 등 비정상적으로 종료되면 `false`
  - `usingSpringWithDamping`
    - 기본값 1. 진동없이 정확히 목표치에 도달
    - 1보다 작을수록 목표치에 도달하기까지 진동을 더 많이함
    - 1보다 크면 목표치에 도달하기 전에 끝남
  - `initialSpringVelocity` : 처음에 밀려오는 속도를 조정. 기본값 0
  - `options` : Animation이 실행될 때 자연스러운 motion을 위한 option
    - `curveLinear` : 처음부터 끝까지 동일한 속도/motion으로 실행
    - `curveEaseIn` : 천천히 출발해서 빠르게 도착
    - `curveEaseOut` : 빠르게 출발해서 천천히 도착
    - `curveEaseInOut` : 천천히 출발해서 빨라지다가 천천히 도착
    - `beginFromCurrentState` : 애니메이션이 취소되거나 계속 반복되거나 할 때, 현재 상태에서 애니메이션이 실행되도록 함

  ```swift
  /* Basic UIView animate */
  UIView.animate(withDuration: 0.6,
                 animations: { }
                )
  
  /* Animation이 끝난 뒤 실행되는 completion */
  UIView.animate(withDuration: 0.6,
                 animations: { },
                 completion: { (isFinished: Bool) in }
                )
  
  /* Animation 시작 시간 delay */
  UIView.animate(withDuration: 0.6,
                 delay: 0,
                 animations: { },
                 completion: { (isFinished: Bool) in }
                )
  
  /* Damping, Velocity 효과 적용 */
  UIView.animate(withDuration: 0.6,
                 delay: 1,
                 usingSpringWithDamping: 0.5,
                 initialSpringVelocity: 0,
                 options: [.curveEaseOut],
                 animations: { },
                 completion: { (isFinished: Bool) in }
                )
  ```

- `UIView.animateKeyFrames()`를 사용해서 순차적인 animation 적용

- `UIView.addKeyframe()`으로 특정 시점에 실행될 animation 지정

  - `withRelativeStartTime` : `animateKeyFrames()`에서 `withDuration`에 설정한 전체 실행 시간을 기준으로 `addKeyFrame()`에서 설정한 `animations`를 실행시킬 시간을 결정
  - `relativeDuration` : `withDuration`에 설정한 전체 실행 시간을 기준으로 `animations`를 얼마나 실행시킬지 결정

  ```swift
  UIView.animateKeyFrames(
    	withDuration: 10,
  		delay: 0,
  		animations: {
        	// 시작시간 : 10 * 0 = 0초
        	// 실행시간 : 10 * 0.25 = 2.5초
  				UIView.addKeyframe(
        			withRelativeStartTime: 0,
  						relativeDuration: 0.25
        			animations: {
        					// statement 
        			}
          )
        
        	// 시작시간 : 10 * 0.25 = 2.5초
        	// 실행시간 : 10 * 0.25 = 2.5초
        	UIView.addKeyframe(
        			withRelativeStartTime: 0.25,
  						relativeDuration: 0.25
        			animations: {
        					// statement 
        			}
          )
      }
  )
  ```

### Transition

- `UIView.transition()`을 사용해서 전환되는 효과의 animation 적용

  - `options` : transition 효과 적용
    - `transitionCrossDissolve` : Fade In-Out 효과
    - `transitionFlipFromTop` : 위로 뒤집는 효과
    - `transitionFlipFromLeft` : 왼쪽으로 뒤집는 효과
    - `transitionFlipFromRight` : 오른쪽으로 뒤집는 효과
    - `transitionFlipFromBottom` : 아래로 뒤집는 효과
    - `transitionCurlUp` : 위로 말려 올라가는 효과
    - `transitionCurlDown` : 아래로 말려 내려가는 효과

  ```swift
  /* from view에서 to view로의 전환 */
  UIView.transition(fram:
                    to:
                    duration:
                    options:
                    completion:
                   )
  
  /* 특정 view에 대한 상태 전환 */
  UIView.transition(
    	with: label,
      duration: 0.5,
      options: [.transitionCrossDissolve],
      animations: { count -= 1 },
      completion: { (isFinished) in
  				// 비동기. 숫자를 0까지 연속적으로 줄이기 위해 재귀 사용
      		DispatchQueue.main.asyncAfter(deadline: .now + 0.5) {
            	guard self.count == 0 else { return self.countDown() }
            self.count = 5
            self.countDownLabel.isHidden = true
          }
      }
  )
  ```

## UIActivityIndicatorView

- 어떤 작업이 수행중임을 나타낼 수 있는 view. 돌아가는 animation 사용 가능
- `activityIndicatorView.startAnimating()` : 돌아가는 animation 시작
- `activityIndicatorView.endAnimationg()` : 돌아가는 animation 종료
- `activityIndicatorView.hidesWhenStopped` : Animation이 멈췄을 때 화면에서 사라지게 함