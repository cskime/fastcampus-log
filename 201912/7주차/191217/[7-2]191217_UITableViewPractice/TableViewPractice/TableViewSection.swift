//
//  TableViewSection.swift
//  TableViewPractice
//
//  Created by giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewSection: UIViewController {
    
    /***************************************************
     Data :  0 부터  100 사이에 임의의 숫자
     섹션 타이틀을 10의 숫자 단위로 설정하고 각 섹션의 데이터는 해당 범위 내의 숫자들로 구성
     e.g.
     섹션 0 - 0부터 9까지의 숫자
     섹션 1 - 10부터 19까지의 숫자
     ***************************************************/
    
    override var description: String { "Practice 2 - Section" }
    
//    let data = [5, 7, 16, 19, 22, 29, 30, 39, 44, 48, 50]
//    let data = Array(1...100)
//    let data = Array(10...50)
    let data = Array(60...78)
    
    var dataDic = [Int: [Int]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        
        for element in data {
            let section = element / 10
            if var values = dataDic[section] {
                values.append(element)
                dataDic[section] = values
            } else {
                dataDic[section] = [element]
            }
        }
        
    }
}


// MARK: - UITableViewDataSource

extension TableViewSection: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataDic.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Array(dataDic.keys)[section])"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = Array(dataDic.keys)[section]
        return dataDic[sectionTitle]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let sectionKey = Array(dataDic.keys)[indexPath.section]
        cell.textLabel?.text = "\(dataDic[sectionKey]?[indexPath.row] ?? -1)"
        return cell
    }
}
