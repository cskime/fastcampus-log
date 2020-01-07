//
//  TouchViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 2020/01/04.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class TouchViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
        // ImageView의 corner radius를 조정하면 이미지가 image view의 크기를 넘어섬
        // Image의 크기가 image view보다 커도 iamge는 그대로 화면에 나타남
        // ImageView가 image에서 imageview 영역 밖으로 벗어나는 부분을 잘라냄
        imageView.clipsToBounds = true
        //    imageView.layer.masksToBounds = true
    }
    
    // MARK: Handle Touch Event
    // UIResponder의 touch event handling method들을 override해서 사용함
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 현재 touch event에 대한 정보를 가져옴
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        
        if imageView.frame.contains(touchPoint) {
            imageView.image = UIImage(named: "cat2")
        }

//        dx = touchPoint.x - imageView.center.x
//        dy = touchPoint.y - imageView.center.y
    }

//    var dx: CGFloat = 0
//    var dy: CGFloat = 0
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        let previousTouchPoint = touch.previousLocation(in: touch.view)
        let currentTouchPoint = touch.location(in: touch.view)

        if imageView.frame.contains(currentTouchPoint) {
//            imageView.center.x = currentTouchPoint.x - dx
//            imageView.center.y = currentTouchPoint.y - dy
            
            let dx = currentTouchPoint.x - previousTouchPoint.x
            let dy = currentTouchPoint.y - previousTouchPoint.y

            imageView.center.x = imageView.center.x + dx
            imageView.center.y = imageView.center.y + dy
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        imageView.image = UIImage(named: "cat1")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}



