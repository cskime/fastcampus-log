//
//  ViewController.swift
//  AppleLoginExample
//
//  Created by Giftbot on 2020/03/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var userIDLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var familyNameLabel: UILabel!
  @IBOutlet private weak var givenNameLabel: UILabel!
  
  var user: User? {
    didSet { configureUserInfo() }
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if user == nil {
      performSegue(withIdentifier: "SegueToLoginVC", sender: self)
    }
  }
  
  private func configureUserInfo() {
    guard let user = user else { return }
    userIDLabel.text = user.id
    emailLabel.text = user.email
    familyNameLabel.text = user.familyName
    givenNameLabel.text = user.givenName
  }
  
  
  // MARK: Action
  
  @IBAction private func signedOut(_ sender: Any) {
    user = nil
    performSegue(withIdentifier: "SegueToLoginVC", sender: self)
  }
}


