//
//  AnimationViewController.swift
//  UIViewAnimation
//
//  Created by giftbot on 2020. 1. 7..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class AnimationViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var countDownLabel: UILabel!
    
    var count = 4 {
        didSet { countDownLabel.text = "\(count)" }
    }
    
    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.isHidden = true
        activityIndicatorView.hidesWhenStopped = true
        
        userIdTextField.frame.origin.x = -self.view.frame.width
        passwordTextField.frame.origin.x = -self.view.frame.width
        loginButton.frame.origin.x = -self.view.frame.width
        
    }
    
    @IBOutlet private weak var testView: UIView!
    func test() {
        let initialFrame = testView.frame
        // withDuration을 이용한 상대적인 시간을 계산하여 animation을 시점에 따라 쪼개서 사용함
        UIView.animateKeyframes(withDuration: 10, delay: 0, animations: {
            // withRelativeStartTime : withDuration을 기준으로 하는 상대적인 시작 시간
            // relativeDuration : withDuration을 기준으로 하는 상대적인 지속 시간
            
            // 10 * 0 = 0초에 시작, 10 * 0.25 = 2.5초동안 지속
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.testView.center.x += 50
                self.testView.center.y -= 150
            }
            
            // 10 * 0.25 = 2.5에 시작, 10 * 0.25 = 2.5초동안 지속
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.testView.center.x += 100
                self.testView.center.y -= 50
            }
            
            // 10 * 0.7 = 7초에 시작, 10 * 0.5 = 5초동안 지속
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.testView.frame = initialFrame
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // withDuration 시간 동안 delay 시간 뒤에 animations를 실행
        UIView.animate(withDuration: 0.6, delay: 0, animations: {
            self.userIdTextField.center.x = self.userIdTextField.superview!.bounds.midX
        })
        
        UIView.animate(withDuration: 0.6, delay: 0.5, animations: {
            self.passwordTextField.center.x = self.passwordTextField.superview!.bounds.midX
        })
        
        
        
        /*
            usingSpringWithDamping : 1이면 진동없이 정확히 목표치에 도달
                - 1보다 작게 주면 진동하면서 목표치에 도달(under damping)
                - 1보다 크게 주면 목표치에 도달하기 전에 끝남(over damping)
            initialSpringVelocity : 처음에 밀려오는 속도를 조정
                - default 0
            daming과 velocity가 서로 영향을 주기 때문에 적절히 조절해야함
            options : bezier curve에 대응되는 애니메이션 전체 동작 속도 설정
                - curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear
                - autoreverse
                - repeat
            completion : 애니메이션이 종료되었을 때 호출됨
                - bool : 애니메이션이 정상적으로 끝났는지 여부를 반환. 중간에 다른 화면으로 가는 등 예기치 않은 상황에서 false
         */
        
        UIView.animate(withDuration: 0.6,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveLinear,
                                 .curveEaseIn,
                                 .curveEaseOut,
                                 .curveEaseInOut],
                       animations: {
            self.loginButton.center.x = self.loginButton.superview!.bounds.midX
        },
                       completion: { (isFinished) in
            print("Finish : ", isFinished)
        })

    }
    
    // MARK: - Action Handler
    
    @IBAction private func didEndOnExit(_ sender: Any) {}
    
    @IBAction private func login(_ sender: Any) {
        self.view.endEditing(true)
        guard countDownLabel.isHidden else { return }
        self.loginButtonAnimation()
        countDown()
    }
    
    func loginButtonAnimation() {
        activityIndicatorView.startAnimating()
        let centerOrigin = loginButton.center
        
        UIView.animateKeyframes(withDuration: 1.6, delay: 0, animations: {
            // 1. 우측 아래로 내려가기
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.loginButton.center.x += 50
                self.loginButton.center.y += 20
            }
            
            // 2. 오른쪽으로 날아가기(45도 회전)
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.loginButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
                self.loginButton.center.x += 150
                self.loginButton.center.y -= 70
                self.loginButton.alpha = 0
            }
            
            // 3. 아래에 위치하도록 적용
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                self.loginButton.transform = .identity
                self.loginButton.center = CGPoint(x: centerOrigin.x, y: self.loginButton.superview!.bounds.height + 120)
            }
            // self.loginButton.superview!.frame    =>
            // self.loginButton.superview!.bounds   =>
            
            // 4. 밑에서 다시 나타나기
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.loginButton.alpha = 1
                self.loginButton.center = centerOrigin
            }
        }) { (isFinished) in
//            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func countDown() {
        countDownLabel.isHidden = false
        
        // transitionCrossDissolve : fade in-out 효과
        // transitionFlipFromTop/Left/Right/Bottom : 해당 방향으로 뒤집는 효과
        
        UIView.transition(from: <#T##UIView#>, to: <#T##UIView#>, duration: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        UIView.transition(with: countDownLabel,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],  // fade in-out
                          animations: { self.count -= 1 }
        ) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard self.count == 0 else { return self.countDown() }
                self.count = 4
                self.countDownLabel.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
}
