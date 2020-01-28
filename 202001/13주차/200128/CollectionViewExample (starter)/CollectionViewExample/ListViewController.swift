//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  let viewControllers = [
    "BasicStoryboardViewController",
    "BasicCodeViewController",
    "CustomCellViewController",
    "FlexibleViewController",
    "SectionViewController",
    "FitItemsViewController",
    "ReorderingViewController",
  ]
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
    cell.textLabel?.text = viewControllers[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vcName = viewControllers[indexPath.row]
    if vcName == "BasicStoryboardViewController" {
      let vc = storyboard!.instantiateViewController(withIdentifier: vcName)
      navigationController?.pushViewController(vc, animated: true)
    } else {
      let namespace = (Bundle.main.infoDictionary!["CFBundleExecutable"] as! String)
      let classType = NSClassFromString("\(namespace).\(vcName)")! as! NSObject.Type
      let vc = classType.init() as! UIViewController
      vc.title = vcName.replacingOccurrences(of: "ViewController", with: "")
      navigationController?.pushViewController(vc, animated: true)
    }
  }

}

