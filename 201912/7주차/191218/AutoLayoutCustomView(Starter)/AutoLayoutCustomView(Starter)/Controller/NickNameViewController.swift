//
//  NickNameViewController.swift
//  AutoLayoutCustomView(Starter)
//
//  Created by Lee on 2019/12/18.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class NickNameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    baseUI()
  }
  
  private func baseUI() {
    view.backgroundColor = .white
    
    let customView = TextFieldType1(frame: .zero, title: "별명을 입력해주세요", buttonTitle: "다 음")
    customView.delegate = self
    view.addSubview(customView)
    
    customView.translatesAutoresizingMaskIntoConstraints = false
    let safeArea = self.view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
        customView.topAnchor.constraint(equalTo: safeArea.topAnchor),
        customView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
        customView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
    ])
  }
  
  private func alertAction(tilte: String?, message: String?) {
    let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "닫 기", style: .cancel)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
}

extension NickNameViewController: TextFieldType1Delegate {
  func buttonDidTap(text: String?) {
    
    
  }
}
