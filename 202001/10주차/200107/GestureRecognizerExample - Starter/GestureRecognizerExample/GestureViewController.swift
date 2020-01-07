//
//  GestureViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 2020/01/04.
//  Copyright © 2020 giftbot. All rights reserved.
//

import AudioToolbox
import UIKit

final class GestureViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    var isZoom = true
    @IBAction private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        if isZoom {
//            imageView.transform = imageView.transform.scaledBy(x: 2, y: 2)
            imageView.transform = imageView.transform.rotated(by: 3.14)
//            imageView.transform = imageView.transform.translatedBy(x: 0, y: 100)
        } else {
            imageView.transform = CGAffineTransform.identity
        }
        isZoom.toggle()
    }
    
    @IBAction private func handleRotateGesture(_ sender: UIRotationGestureRecognizer) {
        // rotation 초기화
        // 항상 imageview 원본에 적용
        
        print(sender.rotation)
        imageView.transform =  imageView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    @IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            print("Left")
            imageView.image = UIImage(named: "cat1")
        case .right:
            print("Right")
            imageView.image = UIImage(named: "cat2")
        case .up:
            print("Up")
        case .down:
            print("Down")
        default:
            print("Unknown : \(sender.direction.rawValue)")
        }
    }
    
    var initialCenter = CGPoint.zero
    @IBAction private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let dragView = sender.view else { return }
        let transition = sender.translation(in: dragView.superview)
        
        if sender.state == .began {
            initialCenter = dragView.center
        }
        
        if sender.state != .cancelled {
            imageView.center.x = initialCenter.x + transition.x
            imageView.center.y = initialCenter.y + transition.y
        } else {
            imageView.center = initialCenter
        }
    }
    
    @IBAction private func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        vibrate()
    }
    
    private func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

