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
    
    // UITableViewCell(홀수행), CustomCell(짝수행)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
    tableView.register(CustomCell.self, forCellReuseIdentifier: "Custom")
  }
}

// MARK: - UITableViewDataSource

extension TableViewCustomCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // cell 재사용. 이렇게하면 캐스팅해서 cell에 넣어도 UITableViewCell 타입이기 때문에 myLabel에 접근할 수 없음. 또 캐스팅해야됨
    let cell: UITableViewCell
    if indexPath.row.isMultiple(of: 2) {
        cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath)// as! CustomCell
        (cell as! CustomCell).myLabel.text = "\(indexPath.row * 1000)"

    } else {
        cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
        
    }
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    cell.imageView?.image = UIImage(named: "bear")
    
    return cell
  }
}


// MARK: - UITableViewDelegate

extension TableViewCustomCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let customCell = cell as? CustomCell else { return }
//        
//        customCell.myLabel.frame = CGRect(
//            x: cell.frame.width - 120, y: 15,
//            width: 100, height: cell.frame.height - 30)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //
    }
}

