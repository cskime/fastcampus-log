//
//  TableViewNumbers.swift
//  TableViewPractice
//
//  Created by giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewNumbers: UIViewController {
  
  /***************************************************
   1부터 50까지의 숫자 출력하기
   ***************************************************/
  
  override var description: String { "Practice 1 - Numbers" }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tableView = UITableView(frame: view.frame)
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
  }
}

extension TableViewNumbers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
}
