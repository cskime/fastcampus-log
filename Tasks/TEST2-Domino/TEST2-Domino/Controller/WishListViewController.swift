//
//  WishListViewController.swift
//  DominoStarter
//
//  Created by Lee on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

final class WishListViewController: UIViewController {
    
    // MARK: Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appearing the view.
        self.updateTableView()
    }
    
    private var products = [Product]()
    private var ordered = [Int]()
    
    private let tableView = UITableView()
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        self.navigationItem.title = "Wish List"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "목록 지우기", style: .plain, target: self, action: #selector(removeList(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "주문", style: .plain, target: self, action: #selector(order(_:)))
        
        self.updateDataSource()
        self.tableView.dataSource = self
        self.tableView.rowHeight = 100
        self.tableView.register(WishCell.self, forCellReuseIdentifier: WishCell.identifier)
        self.view.addSubview(tableView)
        
        self.setupConstraint()
    }
    
    private func setupConstraint() {
        let guide = self.view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    // MARK: Order Action
    
    @objc private func order(_ sender: UIButton) {
        let alert = UIAlertController(title: "결제내역", message: self.orderMessage(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "결제하기", style: .default) { (action) in
            self.removeList(sender)
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "돌아가기", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func orderMessage() -> String {
        var price: Int = 0
        var message: String = ""
        for index in 0..<products.count {
            message += "\(products[index].name) - \(ordered[index])개\n"
            price += products[index].price * ordered[index]
        }
        message += "결제금액 : \(price)원"
        return message
    }
    
    // MARK: Reload Action
    
    @objc private func removeList(_ sender: UIButton) {
        WishList.shared.removeAll()
        updateTableView()
    }
    
    private func updateTableView() {
        self.updateDataSource()
        self.tableView.reloadData()
    }
    
    private func updateDataSource() {
        let wishList: WishListData = WishList.shared.fetch()
        products = wishList.products
        ordered = wishList.ordered
    }
}

// MARK:- UITableViewDataSource

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wishCell = tableView.dequeueReusableCell(withIdentifier: WishCell.identifier, for: indexPath) as! WishCell
        wishCell.updateContent(with: products[indexPath.row])
        return wishCell
    }
}
