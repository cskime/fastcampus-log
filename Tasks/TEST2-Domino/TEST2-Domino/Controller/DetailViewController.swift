//
//  DetailViewController.swift
//  DominoStarter
//
//  Created by Lee on 2019/12/27.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    var product: Product?
    
    // MARK: Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before appearing the view.
        updateLabel()
    }
    
    private func updateLabel() {
        guard let product = product else { return }
        orderControl.updateDisplay(count: WishList.shared.orderedCount(of: product))
    }
    
    private let productImage = UIImageView()
    private let orderControl = OrderControl()
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        self.navigationItem.title = product?.name ?? ""
        
        self.productImage.image = UIImage(named: product?.thumbnail ?? "")
        self.productImage.contentMode = .scaleAspectFit
        self.view.addSubview(productImage)
        
        orderControl.setDelegate(self)
        orderControl.updateDisplay(count: WishList.shared.orderedCount(of: product!))
        self.view.addSubview(orderControl)
        
        self.setupConstraint()
    }
    
    private func setupConstraint() {
        let spacingTop: CGFloat = 40
        let guide = self.view.safeAreaLayoutGuide
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: guide.topAnchor, constant: spacingTop),
            productImage.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            productImage.heightAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1.1),
        ])
        
        let spacingBottom: CGFloat = 40
        orderControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderControl.widthAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 0.7),
            orderControl.centerXAnchor.constraint(equalTo: productImage.centerXAnchor),
            orderControl.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -spacingBottom),
        ])
    }
}

// MARK:- OrderButtonDelegate

extension DetailViewController: OrderButtonDelegate {
    func order(_ sender: UIButton) {
        guard let type = OrderButton.OrderType(rawValue: sender.currentTitle!),
            let product = product else { return }
        
        let count: Int
        switch type {
        case .add:
            count = WishList.shared.perform(command: .add, product: product)
        case .subtract:
            count = WishList.shared.perform(command: .subtract, product: product)
        }
        orderControl.updateDisplay(count: count)
    }
}
