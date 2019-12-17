//
//  ViewController.swift
//  [7-2]191217_TableViewExample
//
//  Created by cskim on 2019/12/17.
//  Copyright © 2019 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


// MARK:- UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
}
