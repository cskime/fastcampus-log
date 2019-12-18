//
//  TableViewRefresh.swift
//  TableViewPractice
//
//  Created by giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewRefresh: UIViewController {
    
    /***************************************************
     UIRefreshControl을 이용해 목록을 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
     랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
     e.g.
     20개 출력 시, 랜덤 숫자의 범위는 0 ~ 70
     40개 출력 시, 랜덤 숫자의 범위는 0 ~ 90
     
     < 참고 >
     (0...10).randomElement()  -  0부터 10사이에 임의의 숫자를 뽑아줌
     ***************************************************/
    
    override var description: String {
        return "Practice 3 - Refresh"
    }
    let tableView = UITableView()
    
    var data = [Int]()
    let numberOfData = 20
    lazy var range = 0...(numberOfData + 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        randomize()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshData() {
        randomize()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func randomize() {
        data.removeAll()
        while data.count < numberOfData {
            data.append(generateRandonNumber())
//            if let random = range.randomElement(), data.contains(random) == false {
//                data.append(random)
//            }
        }
    }
    
    func generateRandonNumber() -> Int {
        #if swift(>=4.2)
        let randomNumber = (0...numberOfData + 50).randomElement()!
        #else
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfData + 50)))
        #endif
        
        guard !data.contains(randomNumber) else { return generateRandonNumber() }
        return randomNumber
    }
    
    func setupTableView() {
        tableView.frame = view.frame
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
}

// MARK: - UITableViewDataSource

extension TableViewRefresh: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
}
