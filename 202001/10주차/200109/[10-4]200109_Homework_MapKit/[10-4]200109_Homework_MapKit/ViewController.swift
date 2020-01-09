//
//  ViewController.swift
//  [10-4]200109_Homework_MapKit
//
//  Created by cskim on 2020/01/09.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "CoreLocation Practice"
        let tableView = UITableView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PageCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    private let pages = [
        String(describing: PracticeViewController.self),
        String(describing: HomeworkViewController.self)
    ]
}

// MARK:- UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath)
        cell.textLabel?.text = pages[indexPath.row]
        return cell
    }
}

// MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = PracticeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = HomeworkViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
