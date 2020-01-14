//
//  ImageAnimationViewController.swift
//  UIViewAnimation
//
//  Created by giftbot on 2020. 1. 7..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ImageAnimationViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var repeatCountLabel: UILabel!
    
    let images = [
        "AppStore", "Calculator", "Calendar", "Camera", "Clock", "Contacts", "Files"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // compactMap : return non-nil element collection
        // animationImages : 애니메이션으로 사용할 이미지를 갖고 있는 것.
        imageView.animationImages = images.compactMap { UIImage(named: $0) }
    }
    
    @IBAction private func startAnimation(_ sender: Any) {
        // animationImages에 들어있는 이미지들을 animation으로 보여줌
        // 1/30초 속도로 image들을 돌아가며 보여줌
        imageView.startAnimating()
    }
    
    @IBAction private func stopAnimation(_ sender: Any) {
        guard imageView.isAnimating else { return }
        imageView.stopAnimating()
    }
    
    @IBAction private func durationStepper(_ sender: UIStepper) {
        durationLabel.text = String(sender.value)
        imageView.animationDuration = sender.value
        // default 0 : 1/30 s
    }
    
    @IBAction private func repeatCountStepper(_ sender: UIStepper) {
        let repeatCount = Int(sender.value)
        repeatCountLabel.text = String(repeatCount)
        imageView.animationRepeatCount = repeatCount
        // default 0 : 무한반복
    }
}
