//
//  ListViewController.swift
//  DominoStarter
//
//  Created by Lee on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK: Properties
    
    private let menuData = MenuData()
    
    // MARK: Intialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private let tableView = UITableView()
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        self.navigationItem.title = "Domino's"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
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
}

// MARK:- UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    // MARK: Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.numberOfCategory()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let image = UIImage(named: menuData.category(at: section))
        let banner = UIImageView(image: image)
        banner.contentMode = .scaleAspectFit
        return banner
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    // MARK: Row in Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.numberOfProducts(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let products = menuData.products(at: indexPath.section)
        productCell.updateContent(with: products[indexPath.row])
        return productCell
    }
}

// MARK:- UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let products = menuData.products(at: indexPath.section)
        detailVC.product = products[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
