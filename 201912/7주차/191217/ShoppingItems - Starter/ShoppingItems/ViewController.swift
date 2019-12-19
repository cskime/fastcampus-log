//
//  ViewController.swift
//  ShoppingItems
//
//  Created by giftbot on 2019. 12. 17..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let itemInfo = ItemInfo.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInfo.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        
        cell.updateName(itemInfo.itemName(at: indexPath.row))
        cell.updateImage(itemInfo.itemImage(at: indexPath.row))
        cell.updateCount(itemInfo.itemCount(at: indexPath.row), at: indexPath.row)

        return cell
    }
}

