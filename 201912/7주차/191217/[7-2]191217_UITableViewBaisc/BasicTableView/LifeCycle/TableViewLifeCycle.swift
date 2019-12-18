//
//  TableViewLifeCycle.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewLifeCycle: UIViewController {
  
  override var description: String { "TableView - LifeCycle" }
  
  let data = Array(1...40)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
  }
}

// MARK: - UITableViewDataSource

extension TableViewLifeCycle: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel!.text = "Cell \(indexPath.row)"
    print("cellForRowAt : \(indexPath.row)")
    return cell
  }
}

// MARK:- UITableViewDelegate

extension TableViewLifeCycle: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will Display Cell : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Did Display Cell : \(indexPath.row)")
    }
}

