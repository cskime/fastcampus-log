//
//  TableViewCustomCell.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewCustomCell: UIViewController {
  
  /***************************************************
   커스텀 셀 사용하기
   ***************************************************/
  
  override var description: String { "TableView - CustomCell" }
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 80
    view.addSubview(tableView)
  }
}

// MARK: - UITableViewDataSource

extension TableViewCustomCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell(style: .default, reuseIdentifier: "CellId")
  }
}


// MARK: - UITableViewDelegate

extension TableViewCustomCell: UITableViewDelegate {
}

