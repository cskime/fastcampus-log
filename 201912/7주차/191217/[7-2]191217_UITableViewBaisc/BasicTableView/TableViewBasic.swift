//
//  TableViewBasic.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewBasic: UIViewController {
    
    override var description: String { "TableView - Basic" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: view.frame)      // default style : .plain
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // dequeueReusableCell(withIdentifier:for:)를 사용하려면 반드시 identifier register해야함
        // 스토리보드에서 identifier를 정해주는 것과 같음
        // Cell 자체에 대한 정보를 넘겨주므로 self를 이용해서 타입 자체를 넘겨줌
        // UITableViewCell()을 넘긴다면 행 하나만 넘기는 느낌. 타입을 넘기면 해당 타입의 모든 cell에 대해 적용되게 하는 느낌
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyCellID")
        // identifier를 같은걸 쓰면 마지막에 register한 cell로 덮어써짐
    }
}

// MARK:- UITableViewDataSource

extension TableViewBasic: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell을 계속 만들어두고 사용하게 되므로 메모리 너무많이 차지함. 재사용하도록 해야함
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        
        
        // 2. 재사용: 미등록. register가 필요없음. 필요할 때 만들어 쓰기 위한 방식
//        let cell: UITableViewCell
//        // TableView에 접근해서 reusable cell을 identifier를 이용해서 가져올 것임
//        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "CellID") {
//            cell = reusableCell
//            print("재사용")
//        } else {
//            // 재사용 큐에 cell이 없으면 만든다
//            cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
//            print("새로생성")
//        }
        
        // 3. 재사용: 선등록(register, storyboard)
        // dequeue했을 때 무조건 그 cell이 있어야하므로 위에서 반드시 해당 identifier로 register해야함
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}



