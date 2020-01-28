//
//  ListViewController.swift
//  CollectionViewExercises
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
  let viewControlls: [(name: String, type: UIViewController.Type)] = [
    (name: "Basic", type: BasicViewController.self),
    (name: "Supplementary", type: SupplementaryViewController.self),
  ]
}


// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControlls.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = viewControlls[indexPath.row].name
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let vcType = viewControlls[indexPath.row].type
    let nextVC = vcType.init()
    nextVC.title = viewControlls[indexPath.row].name
    navigationController?.pushViewController(nextVC, animated: true)
  }
}

