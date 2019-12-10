//
//  CustomView.swift
//  [6-2]191210_DelegateExample
//
//  Created by cskim on 2019/12/10.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

// Protocol이 class에서만 사용할 수 있게 제한하기 위해서 `class`를 채택? 상속?
protocol CustomViewDelegate: class {
    func controlColor(newColor: UIColor?) -> UIColor?
}

class CustomView: UIView {
    
    // 순환 참조 예방을 위해 weak
    weak var delegate: CustomViewDelegate?

    override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        
        set {
            // self.backgroundColor = newValue는 setter를 또 호출하게 되므로 무한 재귀에 빠짐
            
            let color = delegate?.controlColor(newColor: newValue)
            super.backgroundColor = color ?? newValue ?? .black
            print("Color change \(backgroundColor ?? newValue ?? .black)")
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
