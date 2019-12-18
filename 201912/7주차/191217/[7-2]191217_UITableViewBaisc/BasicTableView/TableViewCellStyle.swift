//
//  TableViewCellStyle.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewCellStyle: UIViewController {
  
  override var description: String { "TableView - CellStyle" }
  
  /***************************************************
   셀 스타일 4가지 (default, subtitle, value1, value2)
   ***************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.rowHeight = 70
    tableView.dataSource = self
    view.addSubview(tableView)
  }
}

// MARK: - UITableViewDataSource

extension TableViewCellStyle: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // 재사용
    let cell: UITableViewCell
    
    if indexPath.row % 4 == 0 {
      // 셀 재사용 시도 후 없으면 생성
      cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        ?? UITableViewCell(style: .default, reuseIdentifier: "Default")
    } else if indexPath.row % 4 == 1 {
      cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle")
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
    } else if indexPath.row % 4 == 2 {
      cell = tableView.dequeueReusableCell(withIdentifier: "Value1")
        ?? UITableViewCell(style: .value1, reuseIdentifier: "Value1")
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "Value2")
        ?? UITableViewCell(style: .value2, reuseIdentifier: "Value2")
    }
    
    // 공통 속성 세팅
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    
    return cell
  }
}

