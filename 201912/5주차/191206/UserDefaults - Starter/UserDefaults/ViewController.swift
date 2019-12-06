//
//  ViewController.swift
//  UserDefaults
//
//  Created by giftbot on 2019. 11. 20..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var datePicker: UIDatePicker!
  @IBOutlet private weak var alertSwitch: UISwitch!

  // MARK: Action Handler
  
  @IBAction func saveData(_ button: UIButton) {
    print(datePicker.date)
    UserDefaults.standard.set(datePicker.date, forKey: "Date")
  }
  
  @IBAction func loadData(_ button: UIButton) {
    guard let date = UserDefaults.standard.object(forKey: "Date") as? Date else { return }
    datePicker.setDate(date, animated: true)
  }
}

